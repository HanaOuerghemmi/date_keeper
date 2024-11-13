part of 'get_all_event_by_character_cubit.dart';

@freezed
class GetAllEventByCharacterState with _$GetAllEventByCharacterState {
  const factory GetAllEventByCharacterState.initial() = _Initial;
    const factory GetAllEventByCharacterState.loading() = _Loading;
  const factory GetAllEventByCharacterState.success({required List<EventEntity> events}) = _Success;
  const factory GetAllEventByCharacterState.error({required String message}) = _Error;
}
