/// Result of an operation that can fail in an expected, user-safe way.
sealed class Result<T> {
  /// Creates a result.
  const Result();

  /// Creates a successful result.
  const factory Result.success(T value) = Success<T>;

  /// Creates a failed result.
  const factory Result.failure(AppFailure failure) = Failure<T>;

  /// True only when this result contains a value.
  bool get isSuccess => this is Success<T>;
}

/// A successful [Result].
final class Success<T> extends Result<T> {
  /// Creates a successful result.
  const Success(this.value);

  /// The resulting value.
  final T value;
}

/// A failed [Result].
final class Failure<T> extends Result<T> {
  /// Creates a failed result.
  const Failure(this.failure);

  /// The categorized failure.
  final AppFailure failure;
}

/// Base type for expected application failures.
sealed class AppFailure {
  /// Creates a failure with a safe message for presentation.
  const AppFailure(this.message);

  /// A localized, non-sensitive message suitable for users.
  final String message;
}

/// User input violated a business rule.
final class ValidationError extends AppFailure {
  /// Creates a validation error.
  const ValidationError(super.message);
}

/// A local database operation failed.
final class DatabaseError extends AppFailure {
  /// Creates a database error.
  const DatabaseError(super.message);
}

/// A requested local record is unavailable.
final class NotFoundError extends AppFailure {
  /// Creates a not-found error.
  const NotFoundError(super.message);
}

/// The requested operation conflicts with existing local state.
final class ConflictError extends AppFailure {
  /// Creates a conflict error.
  const ConflictError(super.message);
}

/// Local file access or file creation failed.
final class FileSystemError extends AppFailure {
  /// Creates a file-system error.
  const FileSystemError(super.message);
}

/// Backup creation or validation failed.
final class BackupError extends AppFailure {
  /// Creates a backup error.
  const BackupError(super.message);
}

/// Restore validation or replacement failed.
final class RestoreError extends AppFailure {
  /// Creates a restore error.
  const RestoreError(super.message);
}

/// A security-sensitive operation failed.
final class SecurityError extends AppFailure {
  /// Creates a security error.
  const SecurityError(super.message);
}

/// Required platform permission is unavailable.
final class PermissionError extends AppFailure {
  /// Creates a permission error.
  const PermissionError(super.message);
}
