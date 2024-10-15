import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/constants/app_constant.dart';
import 'package:date_keeper/features/auth/data/datasources/remote_data_source/auth_remote_data_source.dart';
import 'package:date_keeper/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;
  AuthRemoteDataSourceImpl(
      {required this.auth,
      required this.firebaseFirestore,
      required this.googleSignIn});
  @override
  Future<UserModel> logInWithEmail(UserModel userModel) async {
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
  Future<UserModel> signInWithEmail(UserModel userModel) async {
    final body = <String, dynamic>{
      "email": userModel.email,
      "emailVisibility": true,
      // "password": authModel.password,
      // "passwordConfirm": authModel.confirmPassword
    };

    final UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: userModel.email!, password: "12345678");
    final UserModel user = UserModel.fromFirebase(userCredential.user!);

    await firebaseFirestore.collection(collectionUsersName).add(user.toJson());

    log(userCredential.toString());

    return user;
  }

  @override
  Future<UserModel> signInAsAnonymous() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();

    log(userCredential.toString());

    return UserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<UserModel> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // If the user cancels the sign-in process
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with the credential
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    // final User? user = userCredential.user;

    final UserModel user = UserModel.fromFirebase(userCredential.user!);

    await firebaseFirestore.collection(collectionUsersName).add(user.toJson());

    if (user != null) {
      return user;
    } else {
      return null;
    }
  }
}
