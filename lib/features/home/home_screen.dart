import 'dart:async';

import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/presentation/cubit/get_all_character/get_all_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_cubit/getall_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/pages/add_event_screen.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card_widget.dart';
import 'package:date_keeper/features/home/widgets/home_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CharacterModel> characters = [];
  StreamSubscription? characterSubscription;
  StreamSubscription? eventsSubscription;

  List<EventEntity> events = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    _refreshEventList();
  }

  void fetchCharacters() {
    final cubit = context.read<GetAllCharacterCubit>();
    cubit.getAllCharacters();

    // Listen to the cubit's state stream
    characterSubscription = cubit.stream.listen((state) {
      state.maybeWhen(
        loaded: (listCharacters) {
          setState(() {
            characters = listCharacters; // Access listCharacters directly from the loaded state
          });
        },
        orElse: () {
          characters =[];
        },
      );
    });
  }

  void _refreshEventList() {
   final cubit = context.read<GetallEventCubit>();
   cubit.getAllEvents();
 eventsSubscription = cubit.stream.listen((state) {
      state.maybeWhen(
        success: (listEvents) {
          setState(() {
            events = listEvents; // Access listCharacters directly from the loaded state
          });
        },
        orElse: () {
          events =[];
        },
      );
    });
  }
  @override
  void dispose() {
    // Cancel the subscription to avoid memory leaks
    characterSubscription?.cancel();
    eventsSubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   // _refreshEventList();// just to show directly but we need to fix 
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
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: EventList(listEvents: events,)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 1,
        onPressed: () => showAddEventModal(context, _refreshEventList, characters),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.calendar_month_sharp,
          color: whiteColor,
        ),
      ),
    );
  }
}
