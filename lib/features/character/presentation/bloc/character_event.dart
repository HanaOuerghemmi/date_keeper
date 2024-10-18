part of 'character_bloc.dart';

@freezed
class CharacterEvent with _$CharacterEvent {
  const factory CharacterEvent.createCharacter(
      {required CharacterEntity characterEntity,
      required File fileImage}) = _CreateCharacter;
}
