import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_cubit/getall_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/widgets/confirmation_dialog.dart';
import 'package:date_keeper/features/event/presentation/widgets/event_card.dart';
import 'package:date_keeper/features/event/presentation/widgets/swipe_widget.dart';
import 'package:date_keeper/features/event/presentation/widgets/update_event_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<bool> expanded = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() {
    context.read<GetallEventCubit>().getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetallEventCubit, GetallEventState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (events) {
            expanded = List.generate(events.length, (_) => false);

            if (events.isEmpty) {
              return const Center(child: Text('No events yet'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final item = events[index];
                return Dismissible(
                  key: Key(item.title ?? 'event_$index'),
                  background: swipeRightAction(),
                  secondaryBackground: swipeLeftAction(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      final confirmed = await showConfirmationDialog(
                        context,
                        'Confirm Delete',
                        'Are you sure you want to delete ${item.title}?',
                      );
                      if (confirmed) _fetchEvents();
                      return confirmed;
                    } else if (direction == DismissDirection.startToEnd) {
                      final updated = await showUpdatePopup(context, item, index);
                      if (updated != null) _fetchEvents();
                      return updated;
                    }
                    return false;
                  },
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item.title} ${direction == DismissDirection.endToStart ? 'deleted' : 'updated'}")),
                    );
                  },
                  child: EventCard(event: item),
                );
              },
            );
          },
          error: (message) => Center(child: Text('Error: $message')),
          orElse: () => const Center(child: SizedBox.shrink()),
        );
      },
    );
  }
}
