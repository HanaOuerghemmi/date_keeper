import 'package:date_keeper/core/widget/loading.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_with_email_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/sign_up_with_email_page.dart';
import 'package:date_keeper/features/home/home_screen.dart';
import 'package:date_keeper/features/onbording/onbording_screen.dart';
import 'package:date_keeper/features/onbording/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: '/loading',
          name: 'loading',
          builder:  (context, state) => LoadingScreen(),
          ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/loginWithEmail',
          name: 'loginWithEmail',
          builder: (context, state) => LoginWithEmailPage(),
        ),
        GoRoute(
          path: '/signUpWithEmail',
         name: 'signUpWithEmail',

          builder: (context, state) => SignUpWithEmailPage(),
        ),
        
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => HomeScreen(),
        ),
      ],
    );
  }
}
///************ function we will using for navigation if need to forget history root make it true else false 
///
/// */
void navigateGoOption({
  required BuildContext context,
  required String routeName,
  bool forgetHistory = false,
  Map<String, String>? params,
}) {
  if (forgetHistory) {
    // Clear the history and replace the current route with the new one
    context.go(routeName, extra: params);
  } else {
    // Preserve the history and push the new route onto the stack
    context.push(routeName, extra: params);
  }
}
