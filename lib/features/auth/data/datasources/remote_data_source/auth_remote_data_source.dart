import 'package:dartz/dartz.dart';
import 'package:date_keeper/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> logInWithEmail(UserModel userModel);
  Future<UserModel> signInWithEmail(UserModel userModel);
  Future<Unit> logOut();
  Future<UserModel?> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<UserModel> signInAsAnonymous();
  Future<bool> isSignIn();
  Future<String> getCurrentUID();
}
