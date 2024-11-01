import 'package:flutter/material.dart';

Future<bool> showUpdatePopup(
    BuildContext context,  event, int index) async {
  TextEditingController titleController =
      TextEditingController(text: event.title);
  TextEditingController descriptionController =
      TextEditingController(text: event.description);
  TextEditingController typeController =
      TextEditingController(text: event.type);
  
  Color updatedColor = Colors.red;//          event.statusColor; // Track the selected color

  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Event'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Event Type'),
                ),
                DropdownButton<Color>(
                  value: updatedColor,
                  items: [
                    DropdownMenuItem(value: Colors.green, child: Text("Green")),
                    DropdownMenuItem(value: Colors.yellow, child: Text("Yellow")),
                    DropdownMenuItem(value: Colors.red, child: Text("Red")),
                  ],
                  onChanged: (value) {
                    updatedColor = value ?? Colors.green; // Track updated color
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm and close
                },
                child: Text('Update'),
              ),
            ],
          );
        },
      ) ??
      false;
}

