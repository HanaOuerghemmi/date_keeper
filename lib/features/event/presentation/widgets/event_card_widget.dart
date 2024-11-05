import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/presentation/bloc/delete_event_cubit/delete_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_cubit/getall_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/update_event_cubit/update_event_cubit.dart';
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

  Future<bool> _confirmDelete(EventEntity item) async {
    final confirmed = await showConfirmationDialog(
      context,
      'Confirm Delete',
      'Are you sure you want to delete ${item.title}?',
    );

    if (confirmed) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator()),
      );

      context.read<DeleteEventCubit>().deleteEvent(item);

      final deleteCubit = context.read<DeleteEventCubit>();
      deleteCubit.stream.listen((state) {
        state.map(
          initial: (_) {},
          loading: (_) {},
          success: (_) {
            Navigator.of(context).pop();
            _fetchEvents();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Event "${item.title}" deleted successfully')),
            );
          },
          error: (errorState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorState.message)),
            );
          },
        );
      });
    }

    return confirmed;
  }

  Future<bool> _confirmUpdate(EventEntity item, int index) async {
    final updatedEvent = await showUpdatePopup(context, item, index);

    if (updatedEvent != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator()),
      );

      context.read<UpdateEventCubit>().updateEvent(updatedEvent);

      final updateCubit = context.read<UpdateEventCubit>();
      updateCubit.stream.listen((state) {
        state.map(
          initial: (_) {},
          loading: (_) {},
          success: (_) {
            Navigator.of(context).pop();
            _fetchEvents();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Event "${updatedEvent}" updated successfully')),
            );
          },
          error: (errorState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorState.message)),
            );
          },
        );
      });
      return true;
    }
    return false;
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
                  key: Key(item.id!),
                  background: swipeRightAction(),
                  secondaryBackground: swipeLeftAction(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return await _confirmDelete(item);
                    } else if (direction == DismissDirection.startToEnd) {
                      return await _confirmUpdate(item, index);
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
