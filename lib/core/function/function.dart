import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkOpenForFirstTimeStatus(
    {required BuildContext context,
    required Widget baseScreen,
    required Widget firstTimeScreen,
    required String sharedPrefKey}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool? isShowScreen = sp.getBool(sharedPrefKey) ?? false;

  await Future.delayed(const Duration(seconds: 5));

  // if is the first time runing app
  if (isShowScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => baseScreen),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => firstTimeScreen),
    );
  }
}

Future<void> checkAppFlow({
  required BuildContext context,
  required Widget homeScreen,
  required Widget onboardingScreen,
  required Widget loginScreen,
  String onboardingKey = 'isShowOnboarding',
  String loginKey = 'isLoggedIn',
}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  // Check if it's the first time the app is opened (onboarding)
  bool isFirstTimeOpen = sp.getBool(onboardingKey) ?? false;

  // Check if the user is logged in
  bool isLoggedIn = sp.getBool(loginKey) ?? false;

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
  });

  // Simulate splash screen delay
  await Future.delayed(const Duration(seconds: 5));

  if (!isFirstTimeOpen) {
    // First time opening the app: show onboarding screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => onboardingScreen),
    );
  } else if (!isLoggedIn) {
    // Not first time, but user is not logged in: show login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => loginScreen),
    );
  } else {
    // Not first time and user is logged in: show home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homeScreen),
    );
  }
}
