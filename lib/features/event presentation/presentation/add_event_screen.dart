import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/event%20presentation/presentation/widgets/events_ittems.dart';
import 'package:flutter/material.dart';

  void showAddEventModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

  // Controllers to get the input values
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  Color? _selectedColor;

  ///*** List of users (static) */
  List<UserEntity> users = [
    UserEntity(username: 'Alice', profilePictureUrl: 'https://i.pravatar.cc/150?img=1'),
    UserEntity(username: 'Bob', profilePictureUrl: 'https://i.pravatar.cc/150?img=2'),
    UserEntity(username: 'Charlie', profilePictureUrl: 'https://i.pravatar.cc/150?img=3'),
  ];
  UserEntity? _selectedUser;



    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the modal to be scrollable
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add New Event :', style: textStyleTitle,),
                  smallPaddingVert,
                  // Title Input
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  mediumPaddingVert, // Add your padding widget

                  // Description Input
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  mediumPaddingVert, // Add your padding widget

                  // Date Input (with calendar picker)
                  DateItemSelector(dateController: _dateController),
                  mediumPaddingVert, // Add your padding widget

                  const Text(
                    'Choose a Color:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  StatusItemSelector(selectedColor: _selectedColor), // Your color selector

                  // User Checklist
                  const Text(
                    'Select Users:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  UserItemsSelector(selectedUser: _selectedUser, users: users), // Your user selector
                  smallPaddingVert, // Add your padding widget

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission logic here
                        final title = _titleController.text;
                        final description = _descriptionController.text;
                        final date = _dateController.text;
                        final statusColor = _selectedColor;
                        final selectedUser = _selectedUser;

                        // Print form values for demonstration
                        print('Title: $title');
                        print('Description: $description');
                        print('Date: $date');
                        print('Color: $statusColor');
                        print('Selected User: ${selectedUser?.username}');

                        // Clear the form after submission
                        _titleController.clear();
                        _descriptionController.clear();
                        _dateController.clear();
                        Navigator.of(context).pop(); // Close the modal after submission
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

