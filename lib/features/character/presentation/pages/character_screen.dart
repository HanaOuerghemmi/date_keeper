import 'dart:async';
import 'dart:io';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/presentation/cubit/delete_character_cubit/delete_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/cubit/update_character_cubit/update_character_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_by_character_cubit/get_all_event_by_character_cubit.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CharacterScreen extends StatefulWidget {
  final CharacterModel character;
  const CharacterScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late TextEditingController nameController;
  String? newProfilePicture;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.character.name);
    // Fetch events for the character on initialization
    context.read<GetAllEventByCharacterCubit>().getAllEventsByCharacter(widget.character.id!);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _changeProfilePicture() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        newProfilePicture = pickedFile.path;
      });
    }
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _onSave(BuildContext context) {
    final updatedCharacter = CharacterModel(
      id: widget.character.id,
      name: nameController.text,
      profilePicture: newProfilePicture ?? widget.character.profilePicture,
    );

    context.read<UpdateCharacterCubit>().upadateCharacter(updatedCharacter);

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
  }

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Character'),
        content: Text('Are you sure you want to delete this character?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<DeleteCharacterCubit>().deleteCharacter(widget.character.id!);
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Go back to the previous screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Character deleted successfully')),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCharacterCubit, UpdateCharacterState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          loading: (_) {},
          success: (_) {
            Navigator.of(context).pop(); // Close loading dialog
            Navigator.of(context).pop(); // Go back to previous screen
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Character updated successfully')),
            );
          },
          error: (errorState) {
            Navigator.of(context).pop(); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorState.message)),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Character' : widget.character.name ?? 'Character'),
          actions: [
            if (isEditing)
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () => _onSave(context),
              ),
            if (!isEditing)
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: _toggleEditMode,
              ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _onDelete(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: isEditing ? _changeProfilePicture : null,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: newProfilePicture != null
                      ? FileImage(File(newProfilePicture!))
                      : NetworkImage(widget.character.profilePicture ?? '') as ImageProvider,
                  child: isEditing
                      ? Icon(Icons.camera_alt, color: Colors.white, size: 32)
                      : null,
                ),
              ),
              SizedBox(height: 16),
              isEditing
                  ? TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Character Name',
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text(
                      widget.character.name ?? 'Unknown Character',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              SizedBox(height: 16),
              BlocBuilder<GetAllEventByCharacterCubit, GetAllEventByCharacterState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (events) => Expanded(
                      child: events.isEmpty
                          ? Center(child: Text('No events for this character'))
                          : EventList(listEvents:events,)
                          
                        
                    ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text('Error: $message')),
                    orElse: () => Center(child: Text('Something went wrong')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
