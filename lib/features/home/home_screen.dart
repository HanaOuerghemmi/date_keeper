import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/features/character/presentation/cubit/get_all_character/get_all_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_cubit/getall_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/pages/add_event_screen.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card_widget.dart';
import 'package:date_keeper/features/home/widgets/home_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   void initState() {
    context.read<GetAllCharacterCubit>().getAllCharacters();
  }
  void _refreshEventList() {
    context.read<GetallEventCubit>().getAllEvents();
  }

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
            smallPaddingVert,
            SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: EventList()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Adjust the circular radius
        ),
        elevation: 1,
        onPressed: () => showAddEventModal(context, _refreshEventList),
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
