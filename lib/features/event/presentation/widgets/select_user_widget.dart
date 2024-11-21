import 'dart:developer';
import 'dart:ui';
import 'package:date_keeper/core/utils/colors.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:flutter/material.dart';

class SelectUserWidget extends StatefulWidget {
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

  void _toggleSelection(CharacterModel character) {
    setState(() {
      _selectedUser = _selectedUser == character ? null : character;
      widget.onUserSelected(_selectedUser);
      log(_selectedUser == null
          ? 'No user selected'
          : 'Selected user: ${_selectedUser?.name}');
    });
  }

  Widget _buildCharacterItem(CharacterModel character, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleSelection(character),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Profile image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(character.profilePicture ?? ''),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.6),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
              ),
              // Overlay and check icon if selected
              if (isSelected)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: black.withOpacity(0.4),
                  ),
                  child:  Icon(
                    Icons.check_circle,
                    color:whiteColor.withOpacity(0.6),
                    size: 40,
                  ),
                ),
            ],
          ),
          // User name
          const SizedBox(height: 8),
          Text(
            character.name ?? '',
            style: TextStyle(
              color: isSelected ? lightColor : black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.users.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final character = widget.users[index];
          final isSelected = _selectedUser == character;
          return _buildCharacterItem(character, isSelected);
        },
      ),
    );
  }
}
