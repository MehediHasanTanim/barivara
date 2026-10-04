import 'package:flutter/foundation.dart';

/// Immutable application-wide configuration that contains no user secrets.
abstract final class AppConfig {
  /// Name of the local SQLite database introduced in Phase 1.
  static const String databaseName = 'bari_vara.sqlite';

  /// Local schema version, including receipt snapshots.
  static const int databaseVersion = 8;

  /// Current portable-backup package version.
  static const int backupFormatVersion = 1;

  /// Current receipt rendering/snapshot format version.
  static const int receiptTemplateVersion = 1;

  /// Enables diagnostic logging only in debug/profile builds.
  static bool get verboseLoggingEnabled => !kReleaseMode;

  /// Feature switches used to safely stage functionality after the foundation.
  static const FeatureFlags features = FeatureFlags();
}

/// Feature switches for capabilities that are not enabled during Phase 0.
class FeatureFlags {
  /// Creates the default set of disabled pre-release capabilities.
  const FeatureFlags({
    this.enableAppLock = false,
    this.enableLocalNotifications = true,
    this.enableBackupEncryption = false,
  });

  /// Whether app-lock UI and storage are available.
  final bool enableAppLock;

  /// Whether local scheduled reminders are available.
  final bool enableLocalNotifications;

  /// Whether encrypted backup creation is available.
  final bool enableBackupEncryption;
}
