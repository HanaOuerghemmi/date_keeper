import 'package:date_keeper/core/constants/assets_constant.dart';
import 'package:date_keeper/core/utils/colors.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Image.asset(SPLASH_LOGO),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}