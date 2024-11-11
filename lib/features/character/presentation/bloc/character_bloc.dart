// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/usecases/create_character.dart';

part 'character_bloc.freezed.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CreateCaracterUsercase createCaracterUsercase;
  CharacterBloc({
    required this.createCaracterUsercase,
  }) : super(_Initial()) {
    on<CharacterEvent>((event, emit) async {
      await event.when(createCharacter: (characterEntity) async {
        emit(const CharacterState.loading());
        final failureOrCreate =
            await createCaracterUsercase(characterEntity);
        failureOrCreate.fold((failure) async {
          emit(const CharacterState.error(
              message: "error")); //_mapFailureToMessage(failure)
        }, (_) async {
          emit(const CharacterState.loaded());
        });
      });
    });
  }
}
