import 'package:barivara/core/logging/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('release log policy strips exception text and stack traces', () {
    final Object sensitiveError = StateError(
      'tenant 01712000000 at /private/app/bari_vara.sqlite',
    );
    final StackTrace trace = StackTrace.current;

    final AppLogErrorDetails details = AppLogPrivacy.errorDetails(
      includeDiagnostics: false,
      error: sensitiveError,
      stackTrace: trace,
    );

    expect(details.error, isNull);
    expect(details.stackTrace, isNull);
  });

  test('debug log policy retains diagnostics for local development', () {
    final Object error = StateError('query failed');
    final StackTrace trace = StackTrace.current;

    final AppLogErrorDetails details = AppLogPrivacy.errorDetails(
      includeDiagnostics: true,
      error: error,
      stackTrace: trace,
    );

    expect(details.error, same(error));
    expect(details.stackTrace, same(trace));
  });
}
