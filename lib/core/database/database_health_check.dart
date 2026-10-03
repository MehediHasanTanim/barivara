import 'package:barivara/core/database/app_database.dart';
import 'package:drift/drift.dart';

/// Result of an application-startup local database health check.
class DatabaseHealthResult {
  /// Creates a health result.
  const DatabaseHealthResult({
    required this.isHealthy,
    required this.schemaVersion,
    this.recoveryMessage,
  });

  /// Whether the local database opened and passed basic verification.
  final bool isHealthy;

  /// Database schema version recorded by Drift.
  final int schemaVersion;

  /// A safe recovery instruction when the database cannot be used.
  final String? recoveryMessage;
}

/// Checks the local source of truth without exposing low-level SQLite details.
class DatabaseHealthCheck {
  /// Creates a health checker for [database].
  const DatabaseHealthCheck(this.database);

  final AppDatabase database;

  /// Verifies connection availability, foreign keys, and schema metadata.
  Future<DatabaseHealthResult> run() async {
    try {
      final QueryRow foreignKeyRow = await database
          .customSelect('PRAGMA foreign_keys;')
          .getSingle();
      final int foreignKeysEnabled = foreignKeyRow.read<int>('foreign_keys');
      final SchemaMetadataData? metadata = await database
          .select(database.schemaMetadata)
          .getSingleOrNull();

      if (foreignKeysEnabled != 1 || metadata == null) {
        return DatabaseHealthResult(
          isHealthy: false,
          schemaVersion: database.schemaVersion,
          recoveryMessage: 'Local data needs repair. Restore a verified backup if available.',
        );
      }

      return DatabaseHealthResult(
        isHealthy: true,
        schemaVersion: metadata.schemaVersion,
      );
    } on Object {
      return DatabaseHealthResult(
        isHealthy: false,
        schemaVersion: database.schemaVersion,
        recoveryMessage: 'Local data could not be opened. Retry or restore a verified backup.',
      );
    }
  }
}
