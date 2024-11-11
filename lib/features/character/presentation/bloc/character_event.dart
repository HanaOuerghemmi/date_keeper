part of 'character_bloc.dart';

@freezed
class CharacterEvent with _$CharacterEvent {
  const factory CharacterEvent.createCharacter(
      {required CharacterModel characterEntity,}) = _CreateCharacter;
}
