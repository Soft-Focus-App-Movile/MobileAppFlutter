/// Represents the result of an operation that can either succeed or fail.
///
/// This is a sealed class pattern used for error handling without exceptions.
/// - [Success] contains the successful result data
/// - [Error] contains an error message
sealed class Result<T> {
  const Result();
}

/// Represents a successful result containing data of type [T]
class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success(data: $data)';
}

/// Represents a failed result containing an error message
class Error<T> extends Result<T> {
  final String message;

  const Error(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T> &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Error(message: $message)';
}
