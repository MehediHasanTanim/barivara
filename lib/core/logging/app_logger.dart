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
    developer.log(
      message,
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
