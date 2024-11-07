import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/character/domain/usecases/delete_character.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_character_state.dart';
part 'delete_character_cubit.freezed.dart';

class DeleteCharacterCubit extends Cubit<DeleteCharacterState> {
    final DeleteCharacterUseCase deleteCharacterUseCase;

  DeleteCharacterCubit({required this.deleteCharacterUseCase}) : super(DeleteCharacterState.initial());
    Future<void> deleteCharacter(String charcterId) async {
    emit(DeleteCharacterState.loading());

    final result = await deleteCharacterUseCase(charcterId);
    result.fold(
      (failure) {
        log('Failed to delete character: ${failure.message}');
        emit(DeleteCharacterState.error(message: failure.message));
      },
      (_) {
        log('character deleted successfully');
        emit(DeleteCharacterState.success());
      },
    );
  }
}
