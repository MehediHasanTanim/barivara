# Release Verification

Bari Vara has no server dependency. A release candidate is accepted only when
the automated local regression suite and the device checks below pass.

## Automated gate

Run this from a clean checkout:

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test --coverage
flutter build apk --release
```

The suite includes exact-money arithmetic, billing and meter rules, payment
allocation/reversal, deposits, receipt snapshots/PDF font coverage, backup
manifest and restore safety, repository foreign keys and joins, v7-to-v8
migration, and the database-backed collection/move-out journey. The dashboard
stress test seeds 10 properties, 100 units, and 12,000 monthly bills; its
indexed dashboard read must complete in under five seconds in the test
environment.

## Device release checks

- Launch in airplane mode with no SIM and no Wi-Fi. Create a property, unit,
  tenant, tenancy, bill, partial payment, Bengali receipt, repair, and backup.
- Change the device timezone, then verify bills remain in their intended
  billing month. Repeat around a year boundary and February in a leap year.
- Deny export permissions and cancel an export midway; active data must remain
  unchanged and the screen must show a recoverable error.
- Attempt to import a corrupt attachment and restore a corrupt backup; neither
  must replace active records.
- Check Bengali wrapping, Bengali digit/currency formatting, long names, and
  PDF rendering on both supported platforms with enlarged text.
- Verify lock retry throttling, biometric-to-PIN fallback, app-switcher privacy,
  and that an unencrypted backup warning is visible before sharing.

## Release logging review

Release logging records event names only. Exception text and stack traces are
available in debug/profile diagnostics, but are deliberately stripped from a
release error event because they can contain tenant data, bill details, or
app-private file paths. Before distribution, inspect any newly added log calls
to ensure their event message itself contains no name, phone number, NID,
amount, receipt number, or local path.
