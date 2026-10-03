import 'package:barivara/core/database/app_database.dart' as db;
import 'package:barivara/core/database/tables.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:drift/drift.dart';

/// Drift-backed storage for non-financial application preferences.
class DriftSettingsRepository implements SettingsRepository {
  /// Creates a settings repository backed by the local database.
  const DriftSettingsRepository(this._database);

  final db.AppDatabase _database;

  /// Loads a complete settings snapshot, using Bengali-first defaults.
  Future<Result<AppSettingsState>> load() async {
    try {
      final List<db.AppSetting> rows = await _database
          .select(_database.appSettings)
          .get();
      final Map<String, String> values = <String, String>{
        for (final db.AppSetting row in rows) row.key: row.valueJson,
      };
      return Result<AppSettingsState>.success(
        AppSettingsState.fromStorage(values),
      );
    } on Object {
      return Result<AppSettingsState>.failure(
        const DatabaseError('The application settings could not be loaded.'),
      );
    }
  }

  /// Persists a full settings snapshot atomically.
  Future<Result<void>> save(AppSettingsState settings) async {
    try {
      final Map<String, String> values = settings.toStorage();
      await _database.transaction(() async {
        await _database.batch((Batch batch) {
          batch.insertAllOnConflictUpdate(
            _database.appSettings,
            values.entries
                .map(
                  (MapEntry<String, String> entry) =>
                      db.AppSettingsCompanion.insert(
                        key: entry.key,
                        valueJson: entry.value,
                        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
                      ),
                )
                .toList(growable: false),
          );
        });
        if (settings.defaultPropertyId == null) {
          await (_database.delete(_database.appSettings)..where(
                (AppSettings table) =>
                    table.key.equals(AppSettingsKey.defaultPropertyId),
              ))
              .go();
        }
      });
      return Result<void>.success(null);
    } on Object {
      return Result<void>.failure(
        const DatabaseError('The application setting could not be saved.'),
      );
    }
  }

  @override
  Future<Result<String?>> getValue(String key) async {
    try {
      final db.AppSetting? setting = await (_database.select(
        _database.appSettings,
      )..where((AppSettings table) => table.key.equals(key))).getSingleOrNull();
      return Result<String?>.success(setting?.valueJson);
    } on Object {
      return Result<String?>.failure(
        const DatabaseError('The application setting could not be loaded.'),
      );
    }
  }

  @override
  Future<Result<void>> setValue(String key, String valueJson) async {
    try {
      await _database
          .into(_database.appSettings)
          .insertOnConflictUpdate(
            db.AppSettingsCompanion.insert(
              key: key,
              valueJson: valueJson,
              updatedAt: Value<DateTime>(DateTime.now().toUtc()),
            ),
          );
      return Result<void>.success(null);
    } on Object {
      return Result<void>.failure(
        const DatabaseError('The application setting could not be saved.'),
      );
    }
  }
}
