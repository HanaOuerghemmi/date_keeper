import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> logIn(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> signIn(UserEntity userEntity);
  Future<Either<Failure, Unit>> logOut();

  Future<Either<Failure, bool>> isSignIn();

  Future<Either<Failure, String>> getCurrentUID();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithApple();
  Future<Either<Failure, UserEntity>> signInAsAnonymous();
}
