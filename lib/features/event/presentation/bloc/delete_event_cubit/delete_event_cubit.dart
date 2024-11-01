
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/event/domain/usecases/delte_event_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

part 'delete_event_state.dart';
part 'delete_event_cubit.freezed.dart';

class DeleteEventCubit extends Cubit<DeleteEventState> {
  final DeleteEventUsecase deleteEventUsecase;

  DeleteEventCubit({required this.deleteEventUsecase}) : super(DeleteEventState.initial());

  Future<void> deleteEvent(EventEntity? event) async {
    log('event id  cubiit ${event!.id}');
    emit(DeleteEventState.loading());

    final result = await deleteEventUsecase(event);
    result.fold(
      (failure) {
        log('Failed to delete event: ${failure.message}');
        emit(DeleteEventState.error(message: failure.message));
      },
      (_) {
        log('Event deleted successfully');
        emit(DeleteEventState.success());
      },
    );
  }
}
