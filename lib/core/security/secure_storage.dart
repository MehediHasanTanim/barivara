import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Small secure-storage boundary for secrets and app-lock metadata only.
class SecureStorage {
  /// Creates a secure storage boundary.
  SecureStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Reads a secure value.
  Future<String?> read(String key) => _storage.read(key: key);

  /// Writes a secure value.
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  /// Removes a secure value.
  Future<void> delete(String key) => _storage.delete(key: key);
}
