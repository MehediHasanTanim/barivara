import 'dart:developer' as developer;

import 'package:barivara/app/app_config.dart';

/// Safe structured logging abstraction for diagnostics without tenant PII.
abstract interface class AppLogger {
  /// Creates the standard application logger.
  factory AppLogger.standard() = _DeveloperAppLogger;

  /// Records a debug-only diagnostic message.
  void debug(String message);

  /// Records a non-sensitive informational event.
  void info(String message);

  /// Records an error without serializing tenant or financial data.
  void error(String message, {Object? error, StackTrace? stackTrace});
}

/// Diagnostic details that are safe to hand to the platform logger.
///
/// Release logs retain only an event name. Exception text can contain a local
/// path, SQL statement, phone number, or other user-entered value, so it is
/// included solely in debug/profile diagnostics.
class AppLogErrorDetails {
  /// Creates the error details selected by the logging privacy policy.
  const AppLogErrorDetails({this.error, this.stackTrace});

  final Object? error;
  final StackTrace? stackTrace;
}

/// Keeps release diagnostics useful without serialising private local data.
abstract final class AppLogPrivacy {
  /// Returns diagnostic exception details only for non-release logging.
  static AppLogErrorDetails errorDetails({
    required bool includeDiagnostics,
    Object? error,
    StackTrace? stackTrace,
  }) => includeDiagnostics
      ? AppLogErrorDetails(error: error, stackTrace: stackTrace)
      : const AppLogErrorDetails();
}

class _DeveloperAppLogger implements AppLogger {
  static const String _name = 'BariVara';

  @override
  void debug(String message) {
    if (AppConfig.verboseLoggingEnabled) {
      developer.log(message, name: _name, level: 500);
    }
  }

  @override
  void info(String message) {
    if (AppConfig.verboseLoggingEnabled) {
      developer.log(message, name: _name, level: 800);
    }
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    final AppLogErrorDetails details = AppLogPrivacy.errorDetails(
      includeDiagnostics: AppConfig.verboseLoggingEnabled,
      error: error,
      stackTrace: stackTrace,
    );
    developer.log(
      message,
      name: _name,
      level: 1000,
      error: details.error,
      stackTrace: details.stackTrace,
    );
  }
}
