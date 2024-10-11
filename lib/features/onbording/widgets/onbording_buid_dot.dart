import 'package:date_keeper/core/core.dart';
import 'package:flutter/material.dart';

  //********* Build dot indicator for the current page **********/
  Widget onbordingBuildDot({required int index,required int currentPage}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? primaryColor : greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

