part of 'update_character_cubit.dart';

@freezed
class UpdateCharacterState with _$UpdateCharacterState {
  const factory UpdateCharacterState.initial() = _Initial;
   const factory UpdateCharacterState.loading() = _Loading;
  const factory UpdateCharacterState.success({required CharacterEntity character})  = _Sucess;
  const factory UpdateCharacterState.error({required String message}) = _Error;

}
