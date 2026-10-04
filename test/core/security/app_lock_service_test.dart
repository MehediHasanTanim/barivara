import 'package:barivara/core/security/app_lock_service.dart';
import 'package:barivara/core/security/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _MemorySecureStorage storage;
  late _FakeBiometrics biometrics;
  late DateTime now;
  late AppLockService locks;

  setUp(() {
    storage = _MemorySecureStorage();
    biometrics = _FakeBiometrics();
    now = DateTime.utc(2026, 10, 4, 10);
    locks = AppLockService(
      secureStorage: storage,
      biometrics: biometrics,
      clock: () => now,
      iterations: 20,
    );
  });

  test('stores only a salted verifier, never a plaintext PIN', () async {
    await locks.setPin('1234');

    expect((await locks.state()).mode, AppLockMode.pin);
    expect(storage.values.values.join(), isNot(contains('1234')));
    expect(await locks.verifyPin('1234'), PinVerification.accepted);
  });

  test(
    'throttles repeated wrong PIN attempts and accepts after cooldown',
    () async {
      await locks.setPin('1234');
      for (int index = 0; index < 4; index++) {
        expect(await locks.verifyPin('9999'), PinVerification.rejected);
      }
      expect(await locks.verifyPin('9999'), PinVerification.throttled);
      expect(await locks.verifyPin('1234'), PinVerification.throttled);

      now = now.add(const Duration(seconds: 31));
      expect(await locks.verifyPin('1234'), PinVerification.accepted);
    },
  );

  test('biometric prompt is optional and PIN remains the fallback', () async {
    biometrics.available = true;
    await locks.setPin('1234', enableBiometrics: true);

    expect((await locks.state()).mode, AppLockMode.biometric);
    biometrics.result = false;
    expect(await locks.authenticateBiometrics(), isFalse);
    expect(await locks.verifyPin('1234'), PinVerification.accepted);
  });

  test(
    'biometric enrollment change falls back to PIN without removing lock',
    () async {
      biometrics.available = true;
      await locks.setPin('1234', enableBiometrics: true);
      biometrics.available = false;

      expect((await locks.state()).mode, AppLockMode.pin);
      expect(await locks.authenticateBiometrics(), isFalse);
      expect(await locks.verifyPin('1234'), PinVerification.accepted);
    },
  );

  test(
    'lock remains device-local when another app data service is recreated',
    () async {
      await locks.setPin('1234');
      final AppLockService afterRestore = AppLockService(
        secureStorage: storage,
        biometrics: biometrics,
        clock: () => now,
        iterations: 20,
      );

      expect(await afterRestore.verifyPin('1234'), PinVerification.accepted);
    },
  );
}

class _MemorySecureStorage implements SecureKeyValueStore {
  final Map<String, String> values = <String, String>{};

  @override
  Future<void> delete(String key) async => values.remove(key);

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async {
    values[key] = value;
  }
}

class _FakeBiometrics implements BiometricAuthenticator {
  bool available = false;
  bool result = true;

  @override
  Future<bool> authenticate() async => available && result;

  @override
  Future<bool> isAvailable() async => available;
}
