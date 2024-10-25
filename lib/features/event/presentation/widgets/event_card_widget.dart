import 'package:date_keeper/features/event/presentation/widgets/confirmation_dialog.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card.dart';
import 'package:date_keeper/features/event/presentation/widgets/swipe_widget.dart';
import 'package:date_keeper/features/event/presentation/widgets/update_event_popup.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class Event {
  String name;
  String picture;
  String title;
  String description;
  Color statusColor;
  String type;

  Event({
    required this.name,
    required this.picture,
    required this.title,
    required this.description,
    required this.statusColor,
    required this.type,
  });
}

class _EventListState extends State<EventList> {
  List<Event> events = List.generate(
    5,
    (index) => Event(
      name: 'John Doe',
      picture:
          'https://img.freepik.com/photos-premium/homme-portant-lunettes-chemise-blanche-pouce-air_273179-14958.jpg?w=740',
      title: 'Event ${index + 1}',
      description: 'This is the description of Event ${index + 1}.',
      statusColor: index % 2 == 0 ? Colors.green : Colors.red,
      type: index % 2 == 0 ? 'Conference' : 'Meeting',
    ),
  );
  List<bool> expanded = List.generate(5, (_) => false); // Track expanded state

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final item = events[index];
        return Dismissible(
          key: Key(item.title),
          background: swipeRightAction(),
          secondaryBackground: swipeLeftAction(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              return await showConfirmationDialog(
                context,
                'Confirm Delete',
                'Are you sure you want to delete ${item.title}?',
              );
            } else if (direction == DismissDirection.startToEnd) {
              return await showUpdatePopup(context, item, index);
            }
            return false;
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              setState(() {
                events.removeAt(index);
                expanded.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${item.title} deleted")));
            } else if (direction == DismissDirection.startToEnd) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${item.title} updated")));
            }
          },
          child: EventCard(event: item)
          );
      },
    );
  }
  }

