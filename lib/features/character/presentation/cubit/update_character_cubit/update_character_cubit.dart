import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/usecases/update_character.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_character_state.dart';
part 'update_character_cubit.freezed.dart';

class UpdateCharacterCubit extends Cubit<UpdateCharacterState> {
  final UpdateCharacterUsercase upadateCharacterUsercase;
   
  UpdateCharacterCubit({required this.upadateCharacterUsercase}) : super(UpdateCharacterState.initial());

 Future<void> upadateCharacter(CharacterEntity character) async {
    emit(UpdateCharacterState.loading());

    final result = await upadateCharacterUsercase(character);
    result.fold(
      (failure) {
        log('Failed to Update character: ${failure.message}');
        emit(UpdateCharacterState.error(message: failure.message));
      },
      (character) {
        log('character Updated successfully');
        emit(UpdateCharacterState.success(character: character));
      },
    );
  }


}
