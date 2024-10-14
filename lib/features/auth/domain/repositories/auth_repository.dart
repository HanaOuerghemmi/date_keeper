import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> logIn(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> signIn(UserEntity userEntity);
  Future<Either<Failure, Unit>> logOut();
}
