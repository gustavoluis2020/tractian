abstract class Failure implements Exception {
  const Failure({
    this.exception,
    this.message,
  });

  final Exception? exception;
  final String? message;
}

class ServerFailure implements Failure {
  @override
  final Exception? exception;
  @override
  final String? message;
  const ServerFailure({
    this.exception,
    this.message,
  });
}
