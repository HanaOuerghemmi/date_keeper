import 'dart:developer';
import 'package:date_keeper/core/constants/assets_constant.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/core/utils/colors.dart';
import 'package:date_keeper/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_with_email_page.dart';
import 'package:date_keeper/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
                initial: () {},
                loading: () {
                  navigateGoOption(context: context, routeName: '/loading');

                  //context.go( '/loading');
                },
                loaded: (user) {
                  log("state loded");
                  navigateGoOption(
                    context: context,
                    routeName: '/home',
                    forgetHistory: true,
                    params: {
                      'uid': user.uid!,
                    },
                  );

                  // Navigator.of(context).pushReplacementNamed('/home');
                  //context.go('/home');
                  //  Navigator.pushAndRemoveUntil(
                  //  context,
                  //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                  //   (Route<dynamic> route) =>
                  //       false, // This condition will remove all previous routes
                  // );
                },
                error: (message) {},
                orElse: () {});
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(LOGO_APP),
                ),
                CustomButtonAuth(
                  textButton: "with Email",
                  onPressed: () {
                    //  context.go('/loginWithEmail');
                    navigateGoOption(
                        context: context, routeName: '/loginWithEmail');
                  },
                ),
                CustomButtonAuth(
                  textButton: "with google",
                  onPressed: () => _signInWithGoogle(context),
                ),
                CustomButtonAuth(
                  textButton: "with Appele",
                  onPressed: () {},
                ),
                CustomButtonAuth(
                  textButton: "Anonymous",
                  onPressed: () => _signUpAsAnymous(context),
                ),
              ],
            );
          },
        ));
  }

  void _signUpAsAnymous(BuildContext context) {
    // Handle submission logic here
    BlocProvider.of<AuthBloc>(context).add(
      const AuthEvent.signUpAsAnymous(),
    );
  }

  void _signInWithGoogle(BuildContext context) {
    // Handle submission logic here
    BlocProvider.of<AuthBloc>(context).add(
      const AuthEvent.signInWithGoogle(),
    );
  }
}

class CustomButtonAuth extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  const CustomButtonAuth({
    super.key,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
          child: Center(
            child: Text(textButton),
          ),
        ));
  }
}
