import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:date_keeper/features/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(userName: 'userName'),
      body: Column(
        children: [
          const WidgetCharacter(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Adjust the circular radius
        ),
        elevation: 1,
        onPressed: () => navigateGoOption(
          context: context,
          routeName: '/addEvent',
        ),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.calendar_month_sharp,
          color: whiteColor,
        ),
      ),
    );
  }
}
