import 'dart:developer';

import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';

import 'package:date_keeper/features/character/presentation/cubit/get_all_character/get_all_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/pages/create_character_page.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WidgetCharacter extends StatefulWidget {
  const WidgetCharacter({super.key});

  @override
  State<WidgetCharacter> createState() => _WidgetCharacterState();
}

class _WidgetCharacterState extends State<WidgetCharacter> {
  @override
  void initState() {
    super.initState();
    _fetchCharcter();
  }

  void _fetchCharcter() {
    context.read<GetAllCharacterCubit>().getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    log('widget characters');
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: 105,
      //   decoration: BoxDecoration(
      //     color: whiteColor,
      //     boxShadow: [
      //       BoxShadow(
      //         color: black.withOpacity(0.2),
      //         spreadRadius: 2,
      //         blurRadius: 5,
      //         offset: Offset(0, 3),
      //       ),
      //     ],
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 10),
      //     child: 
      //   ),
      // ),
      Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //*****  add new charcter *************/
              CharcterItemWidget(
                onTap: () => showCreateCharacterDialog(context),
                image: Icon(Icons.add, size: 30),
                text: 'New',
              ),

              //*****  list all charcter *************/

              Expanded(
                child: BlocConsumer<GetAllCharacterCubit, GetAllCharacterState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      error: () {},
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      initial: () =>
                          const WidgetCharacterShimmer(),
                      loading: () => const Center(
                          child:
                              WidgetCharacterShimmer(),), //! change this with shimmer 
                      loaded: (characters) => characters.isEmpty
                          ? const Center(child: Text("No users available."))
                          : 
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: characters.length,
                                itemBuilder: (context, index) {
                                  final character = characters[index];
                                  return CharcterItemWidget(
                                    text: character.name ?? '',
                                    image: Image.network(
                                      character.profilePicture!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                        Icons.person,
                                        size: 50 * 0.6,
                                        color: Colors.grey,
                                      ),
                                    ),
                            
                                    // character.profilePicture ?? '',
                                    onTap: () => navigateGoOption(
                                        context: context,
                                        routeName: '/charcter',
                                        params: character),
                                  );
                                },
                              ),
                          ),
                      orElse: () => Center(child: Text('Unexpected state')),
                    );
                  },
                ),
              ),
            ],
          ),
    ]);
  }
}

class CharcterItemWidget extends StatelessWidget {
  final Function() onTap;
  final Widget image;
  final String text;
  final double size;

  const CharcterItemWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    this.size = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: lightColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(child: image)),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
