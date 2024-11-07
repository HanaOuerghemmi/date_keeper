import 'package:date_keeper/core/widget/loading.dart';
import 'package:date_keeper/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_with_email_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/main_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/sign_up_with_email_page.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/presentation/pages/character_screen.dart';
import 'package:date_keeper/features/character/presentation/pages/create_character_page.dart';
import 'package:date_keeper/features/event/presentation/pages/add_event_screen.dart';
import 'package:date_keeper/features/home/home_screen.dart';
import 'package:date_keeper/features/onbording/onbording_screen.dart';
import 'package:date_keeper/features/onbording/splash_screen.dart';
import 'package:date_keeper/features/profile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/main',
      routes: [
        GoRoute(
          path: '/main',
          name: 'main',
          builder: (context, state) => const MainPage(),
          //  {
          //   return BlocBuilder<AuthCubit, AuthState>(
          //     builder: (context, authState) {
          //       if (authState is Authenticated) {
          //         return HomeScreen(uid: authState.uid);
          //       }
          //       return SplashScreen();
          //     },
          //   );
          // },
        ),
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
          builder: (context, state) => LoadingScreen(),
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
          builder: (context, state) {
            final params = state.extra as Map<String, dynamic>;
            final uid = params['uid'] as String;
            return HomeScreen(uid: uid);
          },
        ),
        GoRoute(
          path: '/createCaracter',
          name: 'createCaracter',
          builder: (context, state) => CreateCharacterPage(),
        ),
        GoRoute(
            path: '/charcter',
            name: 'charcter',
            builder: (context, state) {
              // Extract parameters using state.extra
    final character = state.extra as CharacterEntity;
        
              return CharacterScreen(
                character: character,
                
              );
            }),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => ProfileScreen(),
        ),
        // GoRoute(
        //   path: '/addEvent',
        //   name: 'addEvent',
        //   builder: (context, state) => AddEventScreen(),
        // ),
      ],
    );
  }
}

///************ function we will using for navigation if need to forget history root make it true else false
///*************        how using  navigateGoOption(context: context, routeName: '/loading',forgetHistory: true );

/// */
void navigateGoOption({
  required BuildContext context,
  required String routeName,
  bool forgetHistory = false,
  Object? params,
}) {
  if (forgetHistory) {
    // Clear the history and replace the current route with the new one
    context.go(routeName, extra: params);
  } else {
    // Preserve the history and push the new route onto the stack
    context.push(routeName, extra: params);
  }
}
