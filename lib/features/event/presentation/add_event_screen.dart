import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to get the input values
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _dateController = TextEditingController();
  Color? _selectedColor;

  // Function to pick a date and format it
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  ///*** list user static */

  List<UserEntity> users = [
    UserEntity(
        username: 'Alice',
        profilePictureUrl: 'https://i.pravatar.cc/150?img=1'),
    UserEntity(
        username: 'Bob', profilePictureUrl: 'https://i.pravatar.cc/150?img=2'),
    UserEntity(
        username: 'Charlie',
        profilePictureUrl: 'https://i.pravatar.cc/150?img=3'),
  ];
  UserEntity? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Events'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Title Input
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
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
                SizedBox(height: 16.0),

                // Description Input
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
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
                SizedBox(height: 16.0),

                // Date Input (with calendar picker)
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                // status color

                Text(
                  'Choose a Color:',
                  style: TextStyle(fontSize: 16.0),
                ),
                RadioListTile<Color>(
                  title: Text('Red'),
                  value: Colors.red,
                  groupValue: _selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      _selectedColor = value;
                    });
                  },
                ),
                RadioListTile<Color>(
                  title: Text('Green'),
                  value: Colors.green,
                  groupValue: _selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      _selectedColor = value;
                    });
                  },
                ),
                RadioListTile<Color>(
                  title: Text('Blue'),
                  value: Colors.blue,
                  groupValue: _selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      _selectedColor = value;
                    });
                  },
                ),

                // User Checklist
                Text(
                  'Select Users:',
                  style: TextStyle(fontSize: 16.0),
                ),
               
               DropdownButton<UserEntity>(
                  value: _selectedUser,
                  hint: Text('Select a user'),
                  isExpanded: true,
                  onChanged: (UserEntity? newValue) {
                    setState(() {
                      _selectedUser = newValue;
                    });
                  },
                  items: users.map((UserEntity user) {
                    return DropdownMenuItem<UserEntity>(
                      value: user,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePictureUrl!),
                            radius: 16,
                          ),
                          SizedBox(width: 10),
                          Text(user.username!),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                smallPaddingVert,

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
                      print('Date: $statusColor');

                      // Clear the form after submission
                      _titleController.clear();
                      _descriptionController.clear();
                      _dateController.clear();
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
