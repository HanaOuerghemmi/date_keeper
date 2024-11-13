import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/usecases/getall_event_by_charactter_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_event_by_character_state.dart';
part 'get_all_event_by_character_cubit.freezed.dart';

class GetAllEventByCharacterCubit extends Cubit<GetAllEventByCharacterState> {
  final GetallEventByCharacterUsecase getallEventByCharacterUsecase;
  GetAllEventByCharacterCubit({required  this.getallEventByCharacterUsecase}) : super(GetAllEventByCharacterState.initial());


  Future<void> getAllEventsByCharacter(String idCharacter) async {
    emit(GetAllEventByCharacterState.loading());

    final result = await getallEventByCharacterUsecase(idCharacter);
    result.fold(
      (failure) {
        log('Failed to get events: ${failure.message}');
        emit(GetAllEventByCharacterState.error(message: failure.message));
      },
      (events) {
        log('get all event charact successfully: $events');
        emit(GetAllEventByCharacterState.success(events: events));
      },
    );
  }

}
