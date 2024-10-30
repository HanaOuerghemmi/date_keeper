part of 'create_event_cubit.dart';

@freezed
class CreateEventState with _$CreateEventState {
  const factory CreateEventState.initial() = _Initial;
  const factory CreateEventState.loading() = _Loading;
  const factory CreateEventState.success({required EventEntity event}) = _Success;
  const factory CreateEventState.error({required String message}) = _Error;
}
