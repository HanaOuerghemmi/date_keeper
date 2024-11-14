import 'dart:developer';

import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/core/utils/colors.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/presentation/cubit/get_all_character/get_all_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/pages/create_character_page.dart';
import 'package:date_keeper/features/character/presentation/widgets/widget_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectUserWidget extends StatefulWidget {
  //
  final List<CharacterModel> users;
  final Function(CharacterModel?) onUserSelected;
  const SelectUserWidget({
    Key? key,
    required this.users,
    required this.onUserSelected,
  }) : super(key: key);

  @override
  State<SelectUserWidget> createState() => _SelectUserWidgetState();
}

class _SelectUserWidgetState extends State<SelectUserWidget> {
  CharacterModel? _selectedUser;

  @override
  Widget build(BuildContext context) {
    log('widget characters');
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.users.length,
                itemBuilder: (context, index) {
                  final character = widget.users[index];

                  return GestureDetector(
                    //! refactor code make just one widget with all thing .....
                    onTap: () {
                      setState(() {
                        if (_selectedUser == null ||
                            _selectedUser != character) {
                          _selectedUser = character;
                          widget.onUserSelected(character);
                          if (character != null) {
                            log('Selected user: ${character.name}');
                          } else {
                            _selectedUser = null;
                            log('No user selected');
                          }
                        } else if (_selectedUser == character) {
                          _selectedUser = null;
                          widget.onUserSelected(null);
                        }
                      });
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CharcterItemWidget(
                            text: character.name ?? '',
                            image: Image.network(
                              character.profilePicture!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.person,
                                size: 50 * 0.6,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (_selectedUser == null ||
                                    _selectedUser != character) {
                                  _selectedUser = character;
                                  widget.onUserSelected(character);
                                  if (character != null) {
                                    log('Selected user: ${character.name}');
                                  } else {
                                    _selectedUser = null;
                                    log('No user selected');
                                  }
                                } else if (_selectedUser == character) {
                                  _selectedUser = null;
                                  widget.onUserSelected(null);
                                }
                              });
                            }),
                        if (character == _selectedUser)
                          const Center(
                            child: Icon(
                              Icons.check,
                              color: whiteColor,
                              size: 70,
                              fill: 1,
                              weight: 10,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
