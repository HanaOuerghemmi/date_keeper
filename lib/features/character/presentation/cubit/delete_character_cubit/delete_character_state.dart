part of 'delete_character_cubit.dart';

@freezed
class DeleteCharacterState with _$DeleteCharacterState {
  const factory DeleteCharacterState.initial() = _Initial;
    const factory DeleteCharacterState.loading() = _Loading;
  const factory DeleteCharacterState.success() = _Sucess;
  const factory DeleteCharacterState.error({required String message}) = _Error;

}
