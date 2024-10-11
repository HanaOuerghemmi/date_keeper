
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domaine/entity/user_entity.dart';
import 'package:date_keeper/features/auth/domaine/repository/auth_repository.dart';

class SigninWithemailUsecase {
  final AuthRepository authRepository;
  SigninWithemailUsecase(this.authRepository);


  Future<Either<Failure, UserEntity>> call(String email, String password, )  {
    return  authRepository.loginWithEmail(email: email,password: password,);
  }
}