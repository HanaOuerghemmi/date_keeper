import 'package:dartz/dartz.dart';
import 'package:date_keeper/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> logIn(UserModel userModel);
  Future<UserModel> signIn(UserModel userModel);
  Future<Unit> logOut();
}
