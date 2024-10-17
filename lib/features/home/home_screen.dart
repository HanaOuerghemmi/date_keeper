import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/features/auth/presentation/pages/login_page.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: Column(
        children: [
          const WidgetCharacter(),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
        navigateGoOption(context: context, routeName: '/login', forgetHistory: true);

              // Navigator.push(
//context,
               // MaterialPageRoute(builder: (context) => LoginPage()),
            //  );
            },
            child: Text("log out"),
          ),
        ],
      ),
    );
  }
}
