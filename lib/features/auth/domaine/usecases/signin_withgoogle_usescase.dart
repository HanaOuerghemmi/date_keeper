
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domaine/entity/user_entity.dart';
import 'package:date_keeper/features/auth/domaine/repository/auth_repository.dart';

class SigninWithgoogleUsescase {
  final AuthRepository authRepository;
  SigninWithgoogleUsescase(this.authRepository);

  Future<Either<Failure, UserEntity>> call()  {
    return  authRepository.signInWithGoogle();
  }
}