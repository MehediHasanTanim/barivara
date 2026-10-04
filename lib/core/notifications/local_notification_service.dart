import 'dart:async';

import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

enum NotificationRoute { bills, dues, dashboard }

class ScheduledReminder {
  const ScheduledReminder({
    required this.id,
    required this.scheduledAt,
    required this.title,
    required this.body,
    required this.route,
  });
  final int id;
  final DateTime scheduledAt;
  final String title;
  final String body;
  final NotificationRoute route;
}

/// Pure calendar logic for all recurring local reminders.
abstract final class ReminderScheduleCalculator {
  static List<ScheduledReminder> build(
    ReminderPreferences preferences, {
    required DateTime now,
  }) {
    final List<ScheduledReminder> reminders = <ScheduledReminder>[];
    if (preferences.billGenerationEnabled) {
      reminders.add(
        ScheduledReminder(
          id: 1001,
          scheduledAt: _nextMonthly(
            preferences.billGenerationDay,
            preferences.hour,
            preferences.minute,
            now,
          ),
          title: 'Generate monthly bills',
          body: 'Review and generate this month\'s rent bills.',
          route: NotificationRoute.bills,
        ),
      );
    }
    if (preferences.rentDueEnabled) {
      reminders.add(
        ScheduledReminder(
          id: 1002,
          scheduledAt: _nextDueDate(
            preferences.rentDueDay,
            preferences.rentDueOffsetDays,
            preferences.hour,
            preferences.minute,
            now,
          ),
          title: 'Rent due reminder',
          body: preferences.rentDueOffsetDays < 0
              ? 'Rent is due soon. Review outstanding bills.'
              : 'Review rent due for this month.',
          route: NotificationRoute.dues,
        ),
      );
    }
    if (preferences.unpaidFollowUpEnabled) {
      reminders.add(
        ScheduledReminder(
          id: 1003,
          scheduledAt: _nextDueDate(
            preferences.rentDueDay,
            preferences.unpaidFollowUpDays,
            preferences.hour,
            preferences.minute,
            now,
          ),
          title: 'Unpaid rent follow-up',
          body: 'Review tenants with unpaid rent.',
          route: NotificationRoute.dues,
        ),
      );
    }
    for (int index = 0; index < preferences.customReminders.length; index++) {
      final CustomReminder custom = preferences.customReminders[index];
      if (custom.enabled) {
        reminders.add(
          ScheduledReminder(
            id: 2000 + index,
            scheduledAt: _nextMonthly(
              custom.dayOfMonth,
              custom.hour,
              custom.minute,
              now,
            ),
            title: custom.title,
            body: 'Landlord reminder',
            route: NotificationRoute.dashboard,
          ),
        );
      }
    }
    return reminders;
  }

  static DateTime _nextDueDate(
    int dueDay,
    int offsetDays,
    int hour,
    int minute,
    DateTime now,
  ) {
    DateTime dueMonth = DateTime(now.year, now.month);
    DateTime candidate = _monthDate(
      dueMonth.year,
      dueMonth.month,
      dueDay,
      hour,
      minute,
    ).add(Duration(days: offsetDays));
    while (!candidate.isAfter(now)) {
      dueMonth = DateTime(dueMonth.year, dueMonth.month + 1);
      candidate = _monthDate(
        dueMonth.year,
        dueMonth.month,
        dueDay,
        hour,
        minute,
      ).add(Duration(days: offsetDays));
    }
    return candidate;
  }

  static DateTime _nextMonthly(int day, int hour, int minute, DateTime now) {
    DateTime candidate = _monthDate(now.year, now.month, day, hour, minute);
    if (!candidate.isAfter(now)) {
      candidate = _monthDate(now.year, now.month + 1, day, hour, minute);
    }
    return candidate;
  }

  static DateTime _monthDate(
    int year,
    int month,
    int day,
    int hour,
    int minute,
  ) => DateTime(
    year,
    month,
    day.clamp(1, DateTime(year, month + 1, 0).day).toInt(),
    hour,
    minute,
  );
}

/// Local-only permission, scheduling, and notification-tap bridge.
class LocalNotificationService {
  LocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();
  final FlutterLocalNotificationsPlugin _plugin;
  final StreamController<NotificationRoute> _routes =
      StreamController<NotificationRoute>.broadcast();
  NotificationRoute? _initialRoute;
  Stream<NotificationRoute> get routes => _routes.stream;

  NotificationRoute? takeInitialRoute() {
    final NotificationRoute? route = _initialRoute;
    _initialRoute = null;
    return route;
  }

  /// Registers callbacks only. Permission is deliberately not requested here.
  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) =>
          _routes.add(_route(response.payload)),
    );
    final NotificationAppLaunchDetails? launch = await _plugin
        .getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      _initialRoute = _route(launch?.notificationResponse?.payload);
    }
  }

  /// Requests OS permission only after the landlord enables a useful reminder.
  Future<bool> requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final bool? androidAllowed = await android
        ?.requestNotificationsPermission();
    final IOSFlutterLocalNotificationsPlugin? ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final bool? iosAllowed = await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    return androidAllowed ?? iosAllowed ?? true;
  }

  /// Safe to call after startup, device reboot recovery, or settings changes.
  Future<void> reschedule(ReminderPreferences preferences) async {
    for (int id = 1001; id <= 1003; id++) {
      await _plugin.cancel(id: id);
    }
    for (int id = 2000; id < 2100; id++) {
      await _plugin.cancel(id: id);
    }
    for (final ScheduledReminder reminder in ReminderScheduleCalculator.build(
      preferences,
      now: DateTime.now(),
    )) {
      await _plugin.zonedSchedule(
        id: reminder.id,
        title: reminder.title,
        body: reminder.body,
        scheduledDate: tz.TZDateTime.from(reminder.scheduledAt, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'rent_reminders',
            'Rent reminders',
            channelDescription:
                'Offline Bari Vara rent and maintenance reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
        payload: reminder.route.name,
      );
    }
  }

  static NotificationRoute _route(String? payload) => switch (payload) {
    'bills' => NotificationRoute.bills,
    'dues' => NotificationRoute.dues,
    _ => NotificationRoute.dashboard,
  };
}
