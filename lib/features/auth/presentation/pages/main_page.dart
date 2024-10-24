import 'package:date_keeper/features/auth/presentation/cubit/auth/auth_cubit.dart';

import 'package:date_keeper/features/home/home_screen.dart';
import 'package:date_keeper/features/onbording/splash_screen.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return HomeScreen(uid: authState.uid);
        }
        return SplashScreen();
      },
    );
    // StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return const HomeScreen(
    //           uid: "",
    //         );
    //       } else {
    //         return const LoginPage();
    //       }
    //     });
  }
}
