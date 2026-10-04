import 'dart:async';

import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/database/database_health_check.dart';
import 'package:barivara/core/logging/app_logger.dart';
import 'package:barivara/core/notifications/local_notification_service.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/core/security/secure_storage.dart';
import 'package:barivara/core/storage/preferences_store.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/data/drift_settings_repository.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Initializes platform-wide application concerns before rendering the app.
void bootstrap(Widget Function(AppServices services) appBuilder) {
  final AppLogger logger = AppLogger.standard();

  runZonedGuarded<void>(
    () {
      unawaited(_initializeAndRun(appBuilder, logger));
    },
    (Object error, StackTrace stackTrace) {
      logger.error(
        'Unhandled asynchronous application error.',
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}

Future<void> _initializeAndRun(
  Widget Function(AppServices services) appBuilder,
  AppLogger logger,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    logger.error(
      'Unhandled Flutter framework error.',
      error: details.exception,
      stackTrace: details.stack,
    );
  };
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  final PreferencesStore preferences = await PreferencesStore.initialize();
  final SecureStorage secureStorage = SecureStorage();
  final AppDatabase database = AppDatabase();
  final DatabaseHealthResult databaseHealth = await DatabaseHealthCheck(
    database,
  ).run();
  final Result<AppSettingsState> loadedSettings = databaseHealth.isHealthy
      ? await DriftSettingsRepository(database).load()
      : Result<AppSettingsState>.success(const AppSettingsState());
  final AppSettingsState settings = switch (loadedSettings) {
    Success<AppSettingsState>(:final value) => value,
    Failure<AppSettingsState>() => const AppSettingsState(),
  };
  final LocalNotificationService notifications = LocalNotificationService();

  try {
    await notifications.initialize();
    // Recreate the next local occurrence after app restart. Android's boot
    // receiver preserves already scheduled notifications between launches.
    await notifications.reschedule(settings.reminders);
  } on Object catch (error, stackTrace) {
    logger.error(
      'Local notification initialization failed.',
      error: error,
      stackTrace: stackTrace,
    );
  }

  final AppServices services = AppServices(
    preferences: preferences,
    secureStorage: secureStorage,
    database: database,
    databaseHealth: databaseHealth,
    notifications: notifications,
    localeCode: settings.language.localeCode,
    themeMode: settings.theme.name,
  );

  if (!databaseHealth.isHealthy) {
    runApp(_StartupFailureApp(message: databaseHealth.recoveryMessage!));
    return;
  }

  runApp(
    ProviderScope(
      overrides: [
        appServicesProvider.overrideWithValue(services),
        initialAppSettingsProvider.overrideWithValue(settings),
      ],
      child: appBuilder(services),
    ),
  );
}

class _StartupFailureApp extends StatelessWidget {
  const _StartupFailureApp({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}
