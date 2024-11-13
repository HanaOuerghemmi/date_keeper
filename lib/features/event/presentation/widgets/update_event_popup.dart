import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/widget/custom_textfield.dart';
import 'package:date_keeper/features/event/presentation/widgets/events_ittems.dart';
import 'package:flutter/material.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

Future<EventEntity?> showUpdatePopup(
    BuildContext context, EventEntity event, int index) async {
  TextEditingController titleController =
      TextEditingController(text: event.title);
  TextEditingController descriptionController =
      TextEditingController(text: event.description);
  TextEditingController typeController =
      TextEditingController(text: event.type);
  TextEditingController dateController =
      TextEditingController(text: event.date);
  TextEditingController selectedColorController =
      TextEditingController(text: event.statusColor);

  return await showDialog<EventEntity>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Event',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    smallPaddingVert,
                    // Avatar and User Name
                    event.user != null
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          event.user!.profilePicture!)),
                                  smallPaddingHor,
                                  Text(
                                    event.user!.name!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          )
                        : SizedBox.shrink(),

                    smallPaddingVert,
                    CustomTextField(
                      controller: titleController,
                      label: 'Title',
                    ),
                    CustomTextField(
                      controller: typeController,
                      label: 'Event Type',
                    ),
                    CustomTextField(
                      controller: descriptionController,
                      label: 'Description',
                      maxLines: 2,
                    ),
                    smallPaddingVert,
                    DateItemSelector(dateController: dateController),
                    smallPaddingVert,
                    FittedBox(
                      child: StatusItemSelector(
                          selectedColorText: selectedColorController),
                    ),
                    mediumPaddingVert,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final updatedEvent = EventEntity(
                              user: event.user,
                              date: dateController.text,
                              id: event.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              type: typeController.text,
                              statusColor: selectedColorController.text,
                            );
                            Navigator.of(context).pop(updatedEvent);
                          },
                          child: Text('Update'),
                        ),
                      ],
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
