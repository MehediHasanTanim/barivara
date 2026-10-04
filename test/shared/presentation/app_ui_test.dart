import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/shared/presentation/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MoneyInput parses exact whole-taka amounts without floating point', () {
    expect(MoneyInput.parseWholeTaka('1250'), Money.fromTaka(1250));
    expect(MoneyInput.parseWholeTaka('-2'), isNull);
    expect(MoneyInput.parseWholeTaka('12.50'), isNull);
  });

  testWidgets('shared states expose clear labels and direct retry action', (
    WidgetTester tester,
  ) async {
    var retries = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: const Scaffold(
          body: AppLoadingState(label: 'Loading local data…'),
        ),
      ),
    );

    expect(find.text('Loading local data…'), findsOneWidget);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppEmptyState(
            icon: Icons.home_outlined,
            title: 'No properties yet',
            message: 'Add a property to begin.',
          ),
        ),
      ),
    );
    expect(find.text('No properties yet'), findsOneWidget);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppErrorState(
            message: 'Local database could not be read.',
            onRetry: () => retries++,
          ),
        ),
      ),
    );
    await tester.tap(find.text('Try again'));
    expect(retries, 1);
  });

  testWidgets('common confirmation requires an explicit confirmation', (
    WidgetTester tester,
  ) async {
    late Future<bool> result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => Scaffold(
            body: ElevatedButton(
              onPressed: () {
                result = AppConfirmationDialog.show(
                  context,
                  title: 'Archive property?',
                  message: 'History stays available.',
                  confirmLabel: 'Archive',
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Archive'));
    await tester.pumpAndSettle();
    expect(await result, isTrue);
  });
}
