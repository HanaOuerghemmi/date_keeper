import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkAppFlow({
  required BuildContext context,
  required String homeScreen,
  required String onboardingScreen,
  required String loginScreen,
  String onboardingKey = 'isShowOnboarding',
  String loginKey = 'isLoggedIn',
}) async {
  // Get the SharedPreferences instance
  SharedPreferences sp = await SharedPreferences.getInstance();

  // Check if it's the first time the app is opened (onboarding)
  bool isFirstTimeOpen = sp.getBool(onboardingKey) ?? false;

  // Check if the user is logged in
  bool isLoggedIn = sp.getBool(loginKey) ?? false;

  // Get the Firebase auth state asynchronously
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // If there's no user, consider the user as logged out
    isLoggedIn = false;
  } else {
    isLoggedIn = true;
  }

  // Simulate splash screen delay
  await Future.delayed(const Duration(seconds: 5));

  // Check if the widget is still mounted before navigating
  if (!context.mounted) return;

  // Navigate based on the app flow state
  if (!isFirstTimeOpen) {
    // First time opening the app: show onboarding screen
    navigateGoOption(context: context, routeName: onboardingScreen);
  } else if (!isLoggedIn) {
    // Not first time, but user is not logged in: show login screen
    navigateGoOption(context: context, routeName: loginScreen);
  } else {
    // Not first time and user is logged in: show home screen
    navigateGoOption(context: context, routeName: homeScreen);
  }
}
//****************************** calculate date left  **************/
int calculateDateDifference({String? dateToCalculate}) {
  // Parse the input date string into a DateTime object
  final date = DateTime.parse(dateToCalculate!);
  final now = DateTime.now();
  final difference = date.difference(now).inDays;
  return difference;
}