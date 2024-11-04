part of 'update_event_cubit.dart';

@freezed
class UpdateEventState with _$UpdateEventState {
  const factory UpdateEventState.initial() = _Initial;
    const factory UpdateEventState.loading() = _Loading;
  const factory UpdateEventState.success({required EventEntity event}) = _Success;
  const factory UpdateEventState.error({required String message}) = _Error;

}
