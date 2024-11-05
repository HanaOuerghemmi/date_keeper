// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:date_keeper/features/character/domain/usecases/get_all_characters_of_user.dart';

part 'get_all_character_cubit.freezed.dart';
part 'get_all_character_state.dart';

class GetAllCharacterCubit extends Cubit<GetAllCharacterState> {
  final GetAllCaractersOfUserUsercase getAllCaractersOfUserUsercase;

  GetAllCharacterCubit({
    required this.getAllCaractersOfUserUsercase,
  }) : super(GetAllCharacterState.initial());

  void getAllCharacters() {
    emit(const GetAllCharacterState.loading());

    try {
      final characterStream = getAllCaractersOfUserUsercase();
      characterStream.listen(
        (result) {
          result.fold(
            (failure) => emit(const GetAllCharacterState.error()),
            (listCharacters) {
              log("Characters loaded: $listCharacters");
              emit(GetAllCharacterState.loaded(listCharacters: listCharacters));
            },
          );
        },
        onError: (_) {
          emit(const GetAllCharacterState.error());
        },
      );
    } catch (e) {
      emit(const GetAllCharacterState.error());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
