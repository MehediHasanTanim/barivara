import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Minimal key/value contract for OS-backed secrets and deterministic tests.
abstract interface class SecureKeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Small secure-storage boundary for secrets and app-lock metadata only.
class SecureStorage implements SecureKeyValueStore {
  /// Creates a secure storage boundary.
  SecureStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Reads a secure value.
  @override
  Future<String?> read(String key) => _storage.read(key: key);

  /// Writes a secure value.
  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  /// Removes a secure value.
  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}
