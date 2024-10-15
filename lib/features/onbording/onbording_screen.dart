import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_with_email_page.dart';

import 'package:date_keeper/features/onbording/widgets/onbording_buid_dot.dart';
import 'package:date_keeper/features/onbording/widgets/onbording_build_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildPages() {
    return [
      onbordingBuildPage(
          imagePath: ONBORDING_FIRST,
          title: ONBORDING_TITLE1,
          subtitle: ONBORDING_SUBTITLE1),
      onbordingBuildPage(
          imagePath: ONBORDING_SECOND,
          title: ONBORDING_TITLE2,
          subtitle: ONBORDING_SUBTITLE2),
      onbordingBuildPage(
          imagePath: ONBORDING_THIRD,
          title: ONBORDING_TITLE3,
          subtitle: ONBORDING_SUBTITLE3),
    ];
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('isShowOnboarding', true); // Set onboarding flag to true
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //********* skip button at top **********/
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 16),
              child: TextButton(
                onPressed: _completeOnboarding,
                child: const Text("Skip"),
              ),
            ),
          ),

          //********* Page view with image and title **********/
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _buildPages(),
            ),
          ),

          //********* DOT PAGE INDICATOR **********/
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _buildPages().length,
                (index) =>
                    onbordingBuildDot(index: index, currentPage: _currentPage),
              ),
            ),
          ),

          //********* Bottom section with next or start button **********/
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == _buildPages().length - 1) {
                    _completeOnboarding();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12), // Padding around the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Rounded corners
                  ),
                ),
                child: Text(
                  _currentPage == _buildPages().length - 1
                      ? "Get Started"
                      : "Next",
                  style: const TextStyle(fontSize: 18, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
