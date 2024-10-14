import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:date_keeper/features/auth/data/datasources/remote_data_source/auth_remote_data_source.dart';
import 'package:date_keeper/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  AuthRemoteDataSourceImpl({required this.auth});
  @override
  Future<UserModel> logIn(UserModel userModel) async {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: userModel.email!, password: "12345678");

    log(userCredential.toString());

    return UserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<Unit> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signIn(UserModel userModel) async {
    final body = <String, dynamic>{
      "email": userModel.email,
      "emailVisibility": true,
      // "password": authModel.password,
      // "passwordConfirm": authModel.confirmPassword
    };

    final UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: userModel.email!, password: "12345678");

    log(userCredential.toString());

    return UserModel.fromFirebase(userCredential.user!);
  }
}
