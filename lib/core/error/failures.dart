import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  // Constructor with an optional message
  const Failure([this.message = 'An unexpected error occurred.']);

  @override
  List<Object?> get props => [message];
}

class OfflineFailure extends Failure {
  // Optional custom message for this failure type
  const OfflineFailure([String message = 'No internet connection.']) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error. Please try again later.']) : super(message);
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure([String message = 'No data found in cache.']) : super(message);
}
