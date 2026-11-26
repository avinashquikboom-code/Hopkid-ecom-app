abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection. Please try again.']);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed. Please log in again.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Unable to read local storage.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
