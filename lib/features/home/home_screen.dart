import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:date_keeper/features/event/presentation/add_event_screen.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card_widget.dart';
import 'package:date_keeper/features/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(userName: 'userName', profileImageUrl: '',),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const WidgetCharacter(),
            mediumPaddingVert,
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(height: 380, child: EventList()),
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
        //  navigateGoOption(
        //                     context: context,
        //                     routeName: '/addEvent',
        //                 ),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.calendar_month_sharp,
          color: whiteColor,
        ),
      ),
    );
  }
}
