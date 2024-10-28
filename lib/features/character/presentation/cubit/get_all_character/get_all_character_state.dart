part of 'get_all_character_cubit.dart';

@freezed
class GetAllCharacterState with _$GetAllCharacterState {
  const factory GetAllCharacterState.initial() = _Initial;
  const factory GetAllCharacterState.loading() = _Loading;
  const factory GetAllCharacterState.loaded(
      {required List<CharacterEntity> listCharacters}) = _Loaded;
  const factory GetAllCharacterState.error() = _Error;
}
