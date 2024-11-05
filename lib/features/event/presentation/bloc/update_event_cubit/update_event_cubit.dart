import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/usecases/update_event_usecas.dart';

part 'update_event_state.dart';
part 'update_event_cubit.freezed.dart';

class UpdateEventCubit extends Cubit<UpdateEventState> {
  final UpdateEventUsecase updateEventUsecase ;
  UpdateEventCubit({required this.updateEventUsecase}) : super(UpdateEventState.initial());

  Future<void> updateEvent(EventEntity event) async {
    emit(UpdateEventState.loading());

    final result = await updateEventUsecase(event);
    result.fold(
      (failure) {
        log('Failed to create event: ${failure.message}');
        emit(UpdateEventState.error(message: failure.message));
      },
      (createdEvent) {
        log('Event created successfully: $createdEvent');
        emit(UpdateEventState.success(event: createdEvent));
      },
    );
  }
}
