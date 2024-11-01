import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';



class EventCard extends StatefulWidget {
  final EventEntity event;

  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isExpanded = false; // Track expansion for the current card

  @override
  Widget build(BuildContext context) {
    // Handling null or empty descriptions safely
    final descriptionText = widget.event.description ?? '';
    final hasLongDescription = descriptionText.length > 25;
    final displayDescription = isExpanded || !hasLongDescription
        ? descriptionText
        : '${descriptionText.substring(0, 25)}...';

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
                  backgroundImage: NetworkImage(''), // Event picture
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
                            widget.event.title ?? 'Untitled',
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
                              color:  Colors.grey, // Event status color
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(widget.event.id!),
                      Text(
                        widget.event.type ?? 'Unknown Type',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '12 days', // Event duration, hardcoded for now
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              displayDescription.isNotEmpty
                  ? displayDescription
                  : 'No description available',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                'Type: ${widget.event.type ?? 'Unknown'}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                'Event Date: ${widget.event.date}', // Display event date here
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
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
