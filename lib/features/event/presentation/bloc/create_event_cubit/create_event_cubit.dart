import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/event/domain/usecases/creat_event_usescase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

part 'create_event_cubit.freezed.dart';
part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
   final CreatEventUsescase creatEventUsescase;

  CreateEventCubit({
    required this.creatEventUsescase,
  }) : super(CreateEventState.initial());

  Future<void> createEvent(EventEntity event) async {
    emit(CreateEventState.loading());

    final result = await creatEventUsescase(event);
    result.fold(
      (failure) {
        log('Failed to create event: ${failure.message}');
        emit(CreateEventState.error(message: failure.message));
      },
      (createdEvent) {
        log('Event created successfully: $createdEvent');
        emit(CreateEventState.success(event: createdEvent));
      },
    );
  }
}
