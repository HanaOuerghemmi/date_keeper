import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/event/domain/usecases/getall_event_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

part 'getall_event_cubit.freezed.dart';
part 'getall_event_state.dart';

class GetallEventCubit extends Cubit<GetallEventState> {
  final GetAllEventUsecase getAllEventUsecase;

  GetallEventCubit({required this.getAllEventUsecase}) : super(GetallEventState.initial());

  Future<void> getAllEvents() async {
    emit(GetallEventState.loading());

    final result = await getAllEventUsecase();
    result.fold(
      (failure) {
        log('Failed to retrieve events: ${failure.message}');
        emit(GetallEventState.error(message: failure.message));
      },
      (events) {
        log('Events retrieved successfully: $events');
        emit(GetallEventState.success(events: events));
      },
    );
  }
}
