// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:date_keeper/features/character/domain/usecases/get_all_characters_of_user.dart';

part 'get_all_character_cubit.freezed.dart';
part 'get_all_character_state.dart';

class GetAllCharacterCubit extends Cubit<GetAllCharacterState> {
  final GetAllCaractersOfUserUsercase getAllCaractersOfUserUsercase;
  late final Stream<Either<Failure, List<CharacterEntity>>> _characterStream;
  GetAllCharacterCubit({
    required this.getAllCaractersOfUserUsercase,
  }) : super(GetAllCharacterState.initial()) {
    _init();
  }

  void _init() {
    emit(GetAllCharacterState.loading());
    _characterStream = getAllCaractersOfUserUsercase();

    _characterStream.listen((result) {
      result.fold(
        (failure) => emit(const GetAllCharacterState.error()),
        (listCharacters) =>
            emit(GetAllCharacterState.loaded(listCharacters: listCharacters)),
      );
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Stream<void> getAllCharacters() async* {
    emit(const GetAllCharacterState.loading());
    try {
      final streamResponse = getAllCaractersOfUserUsercase();
      streamResponse.listen(
        (response) {
          response.fold(
            (failure) => emit(const GetAllCharacterState.error()),
            (listCharacters) {
              log(listCharacters.toString() + "in cubit");
              emit(GetAllCharacterState.loaded(listCharacters: listCharacters));
            },
          );
        },
      );
    } catch (_) {
      emit(const GetAllCharacterState.error());
    }
  }
}
