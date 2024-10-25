import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';

class IsSignInUseCase {
  final AuthRepository authRepository;

  IsSignInUseCase({required this.authRepository});

  Future<Either<Failure, bool>> call() async {
    return authRepository.isSignIn();
  }
}
