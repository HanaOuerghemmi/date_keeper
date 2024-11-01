import 'dart:developer';

import 'package:date_keeper/features/event/domain/usecases/creat_event_usescase.dart';
import 'package:date_keeper/features/event/presentation/widgets/events_ittems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/presentation/bloc/create_event_cubit/create_event_cubit.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void showAddEventModal(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  Color? selectedColor ;
  UserEntity? _selectedUser;
      log(' color  +++++++++++++ +++ +++++ $selectedColor');

  // Static list of users for selection
  final List<UserEntity> users = [
    UserEntity(username: 'Alice', profilePictureUrl: 'https://i.pravatar.cc/150?img=1'),
    UserEntity(username: 'Bob', profilePictureUrl: 'https://i.pravatar.cc/150?img=2'),
    UserEntity(username: 'Charlie', profilePictureUrl: 'https://i.pravatar.cc/150?img=3'),
  ];
String _colorToString(Color? color) {
  switch (color?.value) {
    case 0xFFF44336:
      return "Red";
    case 0xFFFFEB3B:
      return "Yellow";
    case 0xFF4CAF50:
      return "Green";
    default:
      return "Unknown Color";
  }
}



  // Method to submit event
  void submitEvent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String statusColor = _colorToString(selectedColor);
      log(' color $statusColor ++++++++ +++ +++++ $selectedColor');
      final EventEntity event = EventEntity(
        
        user: null,
        title: _titleController.text,
        description: _descriptionController.text,
        statusColor:_colorToString(selectedColor),
        date: _dateController.text,
        type: '',
      );

      // Trigger event creation
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
             loading: () {
             },
             success: (_) {
              //  Close modal on success
               Navigator.pop(context);
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('event aded successful')),
               );
             },
             error: (message) {
                //Show error message
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(message)),
               );
             },
            orElse:
             () {}
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
                     // Date Input (with calendar picker)
                  DateItemSelector(dateController: _dateController),
                  mediumPaddingVert, // Add your padding widget

                  const Text(
                    'Choose a Color:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  StatusItemSelector(selectedColor: selectedColor,), // Your color selector

                  // User Checklist
                  const Text(
                    'Select Users:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  UserItemsSelector(selectedUser: _selectedUser, users: users), // Your user selector
                  smallPaddingVert, // Add your padding widget
                    state.maybeWhen(
                      loading: () => Center(child: CircularProgressIndicator()),
                      orElse: () => ElevatedButton(
                        onPressed: () => submitEvent(context),
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
