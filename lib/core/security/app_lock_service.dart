import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:barivara/core/security/secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:local_auth/local_auth.dart';

enum AppLockMode { disabled, pin, biometric }

enum PinVerification { accepted, rejected, throttled, unavailable }

/// A testable boundary around the platform biometric prompt.
abstract interface class BiometricAuthenticator {
  Future<bool> isAvailable();
  Future<bool> authenticate();
}

/// Uses the operating system prompt solely as a convenience unlock method.
class LocalAuthBiometricAuthenticator implements BiometricAuthenticator {
  LocalAuthBiometricAuthenticator({LocalAuthentication? authentication})
    : _authentication = authentication ?? LocalAuthentication();

  final LocalAuthentication _authentication;

  @override
  Future<bool> isAvailable() async {
    try {
      return await _authentication.canCheckBiometrics &&
          await _authentication.isDeviceSupported();
    } on LocalAuthException {
      return false;
    } on Object {
      return false;
    }
  }

  @override
  Future<bool> authenticate() async {
    try {
      return await _authentication.authenticate(
        localizedReason: 'Unlock Bari Vara to view tenant and financial data.',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
        sensitiveTransaction: false,
      );
    } on LocalAuthException {
      // Enrollment changes and cancelled prompts intentionally fall back to PIN.
      return false;
    } on Object {
      return false;
    }
  }
}

/// Device-local lock state; neither PINs nor verifiers enter the app database.
class AppLockState {
  const AppLockState({
    required this.mode,
    required this.biometricAvailable,
    this.biometricsEnabled = false,
    this.lockedUntil,
  });

  final AppLockMode mode;
  final bool biometricAvailable;
  final bool biometricsEnabled;
  final DateTime? lockedUntil;

  bool get isEnabled => mode != AppLockMode.disabled;
  bool get isThrottled => lockedUntil?.isAfter(DateTime.now().toUtc()) ?? false;
}

/// PIN verifier using PBKDF2-HMAC-SHA256, random salt, and persisted throttling.
class AppLockService {
  AppLockService({
    required this.secureStorage,
    BiometricAuthenticator? biometrics,
    DateTime Function()? clock,
    Random? random,
    this.iterations = 120000,
  }) : _biometrics = biometrics ?? LocalAuthBiometricAuthenticator(),
       _clock = clock ?? DateTime.now,
       _random = random ?? Random.secure();

  final SecureKeyValueStore secureStorage;
  final BiometricAuthenticator _biometrics;
  final DateTime Function() _clock;
  final Random _random;
  final int iterations;

  static const String _recordKey = 'app_lock_record_v1';

  Future<AppLockState> state() async {
    final _LockRecord? record = await _readRecord();
    if (record == null) {
      return const AppLockState(
        mode: AppLockMode.disabled,
        biometricAvailable: false,
      );
    }
    final bool available = await _biometrics.isAvailable();
    return AppLockState(
      mode: record.biometricsEnabled && available
          ? AppLockMode.biometric
          : AppLockMode.pin,
      biometricAvailable: available,
      biometricsEnabled: record.biometricsEnabled,
      lockedUntil: record.lockedUntil,
    );
  }

  /// Creates or replaces the verifier. The supplied PIN is never persisted.
  Future<void> setPin(String pin, {bool enableBiometrics = false}) async {
    _validatePin(pin);
    final Uint8List salt = Uint8List.fromList(
      List<int>.generate(16, (_) => _random.nextInt(256)),
    );
    final Uint8List verifier = _pbkdf2(pin, salt, iterations);
    await _writeRecord(
      _LockRecord(
        salt: base64UrlEncode(salt),
        verifier: base64UrlEncode(verifier),
        iterations: iterations,
        biometricsEnabled: enableBiometrics && await _biometrics.isAvailable(),
        failedAttempts: 0,
      ),
    );
  }

  Future<void> disable() => secureStorage.delete(_recordKey);

  Future<void> setBiometricsEnabled(bool enabled) async {
    final _LockRecord? record = await _readRecord();
    if (record == null) {
      return;
    }
    await _writeRecord(
      record.copyWith(
        biometricsEnabled: enabled && await _biometrics.isAvailable(),
      ),
    );
  }

  Future<PinVerification> verifyPin(String pin) async {
    final _LockRecord? record = await _readRecord();
    if (record == null) {
      return PinVerification.unavailable;
    }
    final DateTime now = _clock().toUtc();
    if (record.lockedUntil?.isAfter(now) ?? false) {
      return PinVerification.throttled;
    }
    final Uint8List calculated = _pbkdf2(
      pin,
      Uint8List.fromList(base64Url.decode(record.salt)),
      record.iterations,
    );
    if (_constantTimeEquals(calculated, base64Url.decode(record.verifier))) {
      await _writeRecord(
        record.copyWith(failedAttempts: 0, clearLockedUntil: true),
      );
      return PinVerification.accepted;
    }
    final int failures = record.failedAttempts + 1;
    final Duration? wait = failures < 5
        ? null
        : Duration(seconds: min(300, 30 * (1 << min(4, failures - 5))));
    await _writeRecord(
      record.copyWith(
        failedAttempts: failures,
        lockedUntil: wait == null ? null : now.add(wait),
        clearLockedUntil: wait == null,
      ),
    );
    return wait == null ? PinVerification.rejected : PinVerification.throttled;
  }

  /// A failed biometric prompt deliberately leaves PIN as the fallback path.
  Future<bool> authenticateBiometrics() async {
    final _LockRecord? record = await _readRecord();
    if (record == null || !record.biometricsEnabled) return false;
    if (record.lockedUntil?.isAfter(_clock().toUtc()) ?? false) return false;
    return _biometrics.authenticate();
  }

  Future<_LockRecord?> _readRecord() async {
    final String? raw = await secureStorage.read(_recordKey);
    if (raw == null) return null;
    try {
      return _LockRecord.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      // Corrupt secure-storage state must never disable an unknown lock.
      return null;
    }
  }

  Future<void> _writeRecord(_LockRecord record) =>
      secureStorage.write(_recordKey, jsonEncode(record.toJson()));

  static void _validatePin(String pin) {
    if (!RegExp(r'^\d{4,12}$').hasMatch(pin)) {
      throw ArgumentError('Use a 4 to 12 digit PIN.');
    }
  }

  static Uint8List _pbkdf2(String pin, Uint8List salt, int rounds) {
    final Hmac hmac = Hmac(sha256, utf8.encode(pin));
    final BytesBuilder output = BytesBuilder(copy: false);
    int block = 1;
    while (output.length < 32) {
      final BytesBuilder input = BytesBuilder(copy: false)
        ..add(salt)
        ..add(<int>[0, 0, 0, block]);
      List<int> value = hmac.convert(input.takeBytes()).bytes;
      final List<int> result = List<int>.from(value);
      for (int round = 1; round < rounds; round++) {
        value = hmac.convert(value).bytes;
        for (int index = 0; index < result.length; index++) {
          result[index] ^= value[index];
        }
      }
      output.add(result);
      block++;
    }
    return Uint8List.fromList(output.takeBytes().sublist(0, 32));
  }

  static bool _constantTimeEquals(List<int> first, List<int> second) {
    if (first.length != second.length) return false;
    int difference = 0;
    for (int index = 0; index < first.length; index++) {
      difference |= first[index] ^ second[index];
    }
    return difference == 0;
  }
}

class _LockRecord {
  const _LockRecord({
    required this.salt,
    required this.verifier,
    required this.iterations,
    required this.biometricsEnabled,
    required this.failedAttempts,
    this.lockedUntil,
  });

  final String salt;
  final String verifier;
  final int iterations;
  final bool biometricsEnabled;
  final int failedAttempts;
  final DateTime? lockedUntil;

  _LockRecord copyWith({
    bool? biometricsEnabled,
    int? failedAttempts,
    DateTime? lockedUntil,
    bool clearLockedUntil = false,
  }) => _LockRecord(
    salt: salt,
    verifier: verifier,
    iterations: iterations,
    biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
    failedAttempts: failedAttempts ?? this.failedAttempts,
    lockedUntil: clearLockedUntil ? null : lockedUntil ?? this.lockedUntil,
  );

  Map<String, Object?> toJson() => <String, Object?>{
    'salt': salt,
    'verifier': verifier,
    'iterations': iterations,
    'biometricsEnabled': biometricsEnabled,
    'failedAttempts': failedAttempts,
    'lockedUntil': lockedUntil?.toUtc().toIso8601String(),
  };

  factory _LockRecord.fromJson(Map<String, dynamic> json) => _LockRecord(
    salt: json['salt']! as String,
    verifier: json['verifier']! as String,
    iterations: json['iterations']! as int,
    biometricsEnabled: json['biometricsEnabled'] as bool? ?? false,
    failedAttempts: json['failedAttempts'] as int? ?? 0,
    lockedUntil: json['lockedUntil'] == null
        ? null
        : DateTime.parse(json['lockedUntil']! as String).toUtc(),
  );
}
