import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:date_keeper/features/event/presentation/pages/add_event_screen.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card_widget.dart';
import 'package:date_keeper/features/home/widgets/home_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
final uidUser = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: HomeAppBar(userName: uidUser.toString()),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const WidgetCharacter(),
            mediumPaddingVert,
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(height: 500, child: EventList()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Adjust the circular radius
        ),
        elevation: 1,
        onPressed: () => showAddEventModal(context),
        // navigateGoOption(
        //   context: context,
        //   routeName: '/addEvent',
        // ),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.calendar_month_sharp,
          color: whiteColor,
        ),
      ),
    );
  }
}
