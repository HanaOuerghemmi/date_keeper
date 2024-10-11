
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domaine/entity/user_entity.dart';
import 'package:date_keeper/features/auth/domaine/repository/auth_repository.dart';

class SignupWithemailUsecase {
  final AuthRepository authRepository;
  SignupWithemailUsecase(this.authRepository);


  Future<Either<Failure, UserEntity>> call(String email, String password, String name)  {
    return  authRepository.signUpWithEmail(email: email,password: password, name: name);
  }
}