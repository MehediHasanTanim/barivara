import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/database/database_health_check.dart';
import 'package:barivara/core/notifications/local_notification_service.dart';
import 'package:barivara/core/security/secure_storage.dart';
import 'package:barivara/core/storage/preferences_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fully initialized application infrastructure available to Riverpod features.
class AppServices {
  /// Creates initialized application services.
  const AppServices({
    required this.preferences,
    required this.secureStorage,
    required this.database,
    required this.databaseHealth,
    required this.notifications,
    required this.localeCode,
    required this.themeMode,
  });

  final PreferencesStore preferences;
  final SecureStorage secureStorage;
  final AppDatabase database;
  final DatabaseHealthResult databaseHealth;
  final LocalNotificationService notifications;
  final String localeCode;
  final String themeMode;
}

/// Root Riverpod service provider, always overridden during bootstrap.
final Provider<AppServices> appServicesProvider = Provider<AppServices>((
  Ref ref,
) {
  throw StateError('AppServices must be initialized during bootstrap.');
});
