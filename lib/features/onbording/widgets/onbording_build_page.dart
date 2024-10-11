import 'package:date_keeper/core/core.dart';
import 'package:flutter/material.dart';
 
 
 Widget onbordingBuildPage(
      {required String imagePath,
      required String title,
      required String subtitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: textStyleTitle,
        ),
        Text(
          subtitle,
          style: textStyleSubtitle
        ),
        Image.asset(imagePath, height: 300, fit: BoxFit.cover),
        const SizedBox(height: 20),
      ],
    );
  }