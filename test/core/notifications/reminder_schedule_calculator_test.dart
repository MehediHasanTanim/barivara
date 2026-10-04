import 'package:barivara/core/notifications/local_notification_service.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReminderScheduleCalculator', () {
    test(
      'calculates next monthly date and clamps a day unavailable in February',
      () {
        final List<ScheduledReminder> reminders =
            ReminderScheduleCalculator.build(
              const ReminderPreferences(
                billGenerationEnabled: true,
                billGenerationDay: 31,
              ),
              now: DateTime(2026, 2, 1, 8),
            );

        expect(reminders.single.id, 1001);
        expect(reminders.single.scheduledAt, DateTime(2026, 2, 28, 9));
        expect(reminders.single.route, NotificationRoute.bills);
      },
    );

    test('moves a before-due reminder forward until it is in the future', () {
      final List<ScheduledReminder> reminders =
          ReminderScheduleCalculator.build(
            const ReminderPreferences(
              rentDueEnabled: true,
              rentDueDay: 1,
              rentDueOffsetDays: -3,
            ),
            now: DateTime(2026, 1, 31, 12),
          );

      expect(reminders.single.scheduledAt, DateTime(2026, 2, 26, 9));
      expect(reminders.single.route, NotificationRoute.dues);
    });

    test('includes enabled custom and unpaid follow-up reminders only', () {
      final List<ScheduledReminder> reminders =
          ReminderScheduleCalculator.build(
            const ReminderPreferences(
              unpaidFollowUpEnabled: true,
              rentDueDay: 5,
              unpaidFollowUpDays: 3,
              customReminders: <CustomReminder>[
                CustomReminder(
                  id: 'water',
                  title: 'Check water pump',
                  dayOfMonth: 10,
                  hour: 10,
                  minute: 30,
                ),
                CustomReminder(
                  id: 'hidden',
                  title: 'Hidden',
                  dayOfMonth: 11,
                  hour: 10,
                  minute: 30,
                  enabled: false,
                ),
              ],
            ),
            now: DateTime(2026, 3, 1, 8),
          );

      expect(reminders.map((ScheduledReminder reminder) => reminder.id), <int>[
        1003,
        2000,
      ]);
      expect(reminders.last.title, 'Check water pump');
      expect(reminders.last.route, NotificationRoute.dashboard);
    });
  });
}
