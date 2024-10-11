import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domaine/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either<Failure, UserEntity>>signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> currentUser();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithApple();
}
