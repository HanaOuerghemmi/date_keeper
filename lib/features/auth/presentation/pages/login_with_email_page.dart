import 'dart:developer';

import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/core/utils/help_padding.dart';
import 'package:date_keeper/core/utils/help_textstyle.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';

import 'package:date_keeper/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_keeper/features/auth/presentation/widgets/custom_validat_textfielld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({super.key});

  @override
  State<LoginWithEmailPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
              initial: () {},
              loading: () {
                navigateGoOption(context: context, routeName: '/loading');

//context.go('/loading') ;
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
                //
                //                context.go('/home') ;
                //  Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                //   (Route<dynamic> route) =>
                //       false, // This condition will remove all previous routes
                // );
              },
              error: (message) {},
              orElse: () {});
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back 👋",
                      style: textStyleSubtitle,
                    ),
                    smallPaddingVert,
                    Text(
                      "Please enter your email & password to sign in.",
                      // style: textStyleText,
                    ),
                    smallPaddingVert,
                    //* using a textfiel with validate function shoing snackbar
                    CustomValidateTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      nameTextField: "Email",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),

                    // TextFieldAuth(
                    //   controller: _emailController,
                    //   nameTextField: "Email",
                    //   prefixIcon: const Icon(
                    //     Icons.email,
                    //     color: blackColor,
                    //   ),
                    // ),

                    CustomValidateTextField(
                      isPassword: true,
                      nameTextField: "Password",
                      controller: _passwordController,
                      prefixIcon: const Icon(
                        Icons.lock,
                        // color: blackColor,
                      ),
                    ),
                    // TextFieldAuth(
                    //   nameTextField: "Password",
                    //   controller: _passwordController,
                    //   obscureText: showPassword,
                    //   prefixIcon: const Icon(
                    //     Icons.lock,
                    //     color: blackColor,
                    //   ),
                    //   suffixIcon: IconButton(
                    //     icon: showPassword
                    //         ? const Icon(Icons.visibility)
                    //         : const Icon(Icons.visibility_off),
                    //     onPressed: () {
                    //       setState(() {
                    //         showPassword = !showPassword;
                    //       });
                    //     },
                    //     color: blackColor,
                    //   ),
                    // ),
                    // ! Custom this in widget to Log In
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, resetPassword.routeName);
                          },
                          child: Text(
                            "Forget Password?",
                            // style:
                            //     textStyleTextBold.copyWith(color: primaryColor),
                          )),
                    ),
                    smallPaddingVert,
                    const Divider(
                      height: 1,
                    ),
                    mediumPaddingVert,
                    // const GoToSignUp(),
                    largePaddingVert,
                    mediumPaddingVert,
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      child: Text("login"),
                    ),
                    Row(
                      children: [
                        Text("don't have accounnt"),
                        TextButton(
                            onPressed: () {
                              navigateGoOption(
                                  context: context,
                                  routeName: '/signUpWithEmail');

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           SignUpWithEmailPage()),
                              // );
                            },
                            child: Text("Sign up"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Handle submission logic here

      BlocProvider.of<AuthBloc>(context).add(
        AuthEvent.logIn(
          userEntity: UserEntity(
            email: _emailController.text.trim(),
          ),
        ),
      );
    }
  }
}
