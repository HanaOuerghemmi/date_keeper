import 'package:flutter/material.dart';

class Event {
  final String picture;
  final String title;
  final String name;
  final String description;
  final Color statusColor;
  final String type;

  Event({
    required this.picture,
    required this.title,
    required this.name,
    required this.description,
    required this.statusColor,
    required this.type,
  });
}

class EventCard extends StatefulWidget {
  final  event;

  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isExpanded = false; // Track expansion for the current card

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.event.picture), // Event picture
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.event.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: widget.event.statusColor, // Event status color
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.event.name,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '12 days',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              isExpanded
                  ? '${widget.event.description} Event Date: 12 Oct 2024, Type: ${widget.event.type}.'
                  : '${widget.event.description.substring(0, 25)}...',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded; // Toggle expansion
                  });
                },
                child: Text(
                  isExpanded ? 'Show Less' : 'Load More',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
