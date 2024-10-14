import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUsercase {
  final AuthRepository authRepository;

  SignInUsercase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call(UserEntity authEntity) async {
    return await authRepository.signIn(authEntity);
  }
}
