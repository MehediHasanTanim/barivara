import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Initializes the local-only reminder system. Scheduling arrives in Phase 12.
class LocalNotificationService {
  /// Creates a local notification service.
  LocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  /// Registers the local notification plugin without requesting permission.
  Future<void> initialize() async {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(settings: settings);
  }
}
