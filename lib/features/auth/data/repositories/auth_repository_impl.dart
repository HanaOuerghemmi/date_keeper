import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/execption.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/core/network/network_info.dart';
import 'package:date_keeper/features/auth/data/datasources/remote_data_source/auth_remote_data_source_impl-firebase.dart';
import 'package:date_keeper/features/auth/data/models/user_model.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> logIn(UserEntity userEntity) async {
    final UserModel userModel = UserModel(
      email: userEntity.email,
    );

    if (await networkInfo.isConnected) {
      try {
        log("in function LogIn  .....");
        final authEntity = await remoteDataSource.logIn(userModel);
        return right(authEntity);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(UserEntity userEntity) async {
    final UserModel userModel = UserModel(
      email: userEntity.email,
      username: userEntity.username,
      // password: authEntity.password,
      // confirmPassword: authEntity.confirmPassword,
    );

    if (await networkInfo.isConnected) {
      try {
        log("in function .....");
        final authEntity = await remoteDataSource.signIn(userModel);
        return right(authEntity);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
