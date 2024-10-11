
import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/home/home_screen.dart';
import 'package:date_keeper/features/onbording/onbording_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAppFlow(context: context, 
    homeScreen: HomeScreen(),
    onboardingScreen: OnboardingScreen(), 
    loginScreen: HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primaryColor,
      body: Center(
        child: Image.asset(SPLASH_LOGO),
      ),
    );
  }
}
