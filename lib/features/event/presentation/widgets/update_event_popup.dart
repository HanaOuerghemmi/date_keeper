import 'package:flutter/material.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

Future<EventEntity?> showUpdatePopup(
    BuildContext context, EventEntity event, int index) async {
  // Initialize controllers with current event values
  TextEditingController titleController =
      TextEditingController(text: event.title);
  TextEditingController descriptionController =
      TextEditingController(text: event.description);
  TextEditingController typeController =
      TextEditingController(text: event.type);

  Color updatedColor = Colors.red; // Track the selected color

  return await showDialog<EventEntity>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                    setState(() {
                      updatedColor = value ?? Colors.green; // Update color
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(null); // Cancel without updating
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Create a new EventEntity with updated details
                  final updatedEvent = EventEntity(
                    user: event.user,
                    date: event.date,
                    id: event.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    type: typeController.text,
                    statusColor: 'red',
                    // Add other fields if needed
                  );
                  Navigator.of(context).pop(updatedEvent); // Confirm update
                },
                child: Text('Update'),
              ),
            ],
          );
        },
      );
    },
  );
}
