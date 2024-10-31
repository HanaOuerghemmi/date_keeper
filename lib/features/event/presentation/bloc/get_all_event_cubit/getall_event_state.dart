part of 'getall_event_cubit.dart';

@freezed
class GetallEventState with _$GetallEventState {
  const factory GetallEventState.initial() = _Initial;
  const factory GetallEventState.loading() = _Loading;
  const factory GetallEventState.success({required List<EventEntity> events}) = _Success;
  const factory GetallEventState.error({required String message}) = _Error;

}
