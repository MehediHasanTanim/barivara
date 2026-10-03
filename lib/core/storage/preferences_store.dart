import 'package:shared_preferences/shared_preferences.dart';

/// Testable wrapper around non-financial local application preferences.
class PreferencesStore {
  /// Creates a preference store.
  PreferencesStore(this._preferences);

  /// Initializes the shared-preferences backing store.
  static Future<PreferencesStore> initialize() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return PreferencesStore(preferences);
  }

  final SharedPreferences _preferences;

  /// Reads a persisted string, if present.
  String? getString(String key) => _preferences.getString(key);

  /// Persists a non-sensitive string setting.
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }
}
