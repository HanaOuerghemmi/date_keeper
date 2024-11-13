import 'dart:developer';
import 'package:date_keeper/features/event/presentation/widgets/events_ittems.dart';
import 'package:date_keeper/features/event/presentation/widgets/select_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/presentation/bloc/create_event_cubit/create_event_cubit.dart';

void showAddEventModal(BuildContext context, Function fetchEvents, List<CharacterModel> users) {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
    final TextEditingController selectedColor = TextEditingController();

  CharacterModel? selectedUser;


  void submitEvent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
     
      final EventEntity event = EventEntity(
        user: selectedUser!.copyWith(id: selectedUser!.id),
        title: _titleController.text,
        description: _descriptionController.text,
        statusColor: selectedColor.text,
        date: _dateController.text,
        type: '',
      );

      context.read<CreateEventCubit>().createEvent(event);
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocConsumer<CreateEventCubit, CreateEventState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () {},
            success: (_) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Event added successfully')),
              );
              fetchEvents();
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Event:',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a title'
                          : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a description'
                          : null,
                    ),
                    DateItemSelector(dateController: _dateController),
                    SizedBox(height: 16),
                    Text(
                      'Choose a Color:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    StatusItemSelector(selectedColorText: selectedColor ),
                    SizedBox(height: 16),
                    Text(
                      'Select Users:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    
                    SelectUserWidget(
                      users: users,
                      onUserSelected: (CharacterModel? user) {
                        selectedUser = user;
                      },
                    ),
                    // UserItemsSelector(
                    //   users: users,
                    //   onUserSelected: (CharacterModel? user) {
                    //     selectedUser = user;
                    //   },
                    // ),
                    SizedBox(height: 16),
                    state.maybeWhen(
                      loading: () => Center(child: CircularProgressIndicator()),
                      orElse: () => ElevatedButton(
                        onPressed: () {
                          submitEvent(context);
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class UserItemsSelector extends StatefulWidget {
  final List<CharacterModel> users;
  final Function(CharacterModel?) onUserSelected;

  UserItemsSelector({
    Key? key,
    required this.users,
    required this.onUserSelected,
  }) : super(key: key);

  @override
  State<UserItemsSelector> createState() => _UserItemsSelectorState();
}

class _UserItemsSelectorState extends State<UserItemsSelector> {
  CharacterModel? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CharacterModel>(
      value: _selectedUser,
      hint: Text('Select a user'),
      isExpanded: true,
      onChanged: (CharacterModel? newValue) {
        setState(() {
          _selectedUser = newValue;
          widget.onUserSelected(newValue);
          if (newValue != null) {
            log('Selected user: ${newValue.name}');
          } else {
            log('No user selected');
          }
        });
      },
      items: widget.users.map((CharacterModel user) {
        return DropdownMenuItem<CharacterModel>(
          value: user,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePicture ?? ''),
                radius: 16,
              ),
              SizedBox(width: 10),
              Text(user.name ?? 'Unknown'),
            ],
          ),
        );
      }).toList(),
    );
  }
}
