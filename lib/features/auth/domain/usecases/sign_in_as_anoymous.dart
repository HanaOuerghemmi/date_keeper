import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';

class SignInAsAnoymousUsercase {
  final AuthRepository authRepository;

  SignInAsAnoymousUsercase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.signInAsAnonymous();
  }
}
