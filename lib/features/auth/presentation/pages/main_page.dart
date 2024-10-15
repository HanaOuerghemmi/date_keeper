import 'package:date_keeper/features/auth/presentation/pages/login_page.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_with_email_page.dart';
import 'package:date_keeper/features/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginPage();
          }
        });
  }
}
