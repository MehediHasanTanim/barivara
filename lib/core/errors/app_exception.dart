/// Typed base exception for expected, user-safe application failures.
sealed class AppException implements Exception {
  /// Creates an application exception with a safe message for presentation.
  const AppException(this.message);

  /// A localized, non-sensitive message suitable for a user interface.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Signals that user input violates a business validation rule.
final class ValidationException extends AppException {
  /// Creates a validation exception.
  const ValidationException(super.message);
}

/// Signals a local persistence operation failed.
final class StorageException extends AppException {
  /// Creates a storage exception.
  const StorageException(super.message);
}
