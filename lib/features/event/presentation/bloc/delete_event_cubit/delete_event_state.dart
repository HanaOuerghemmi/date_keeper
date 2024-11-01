part of 'delete_event_cubit.dart';

@freezed
class DeleteEventState with _$DeleteEventState {
  const factory DeleteEventState.initial() = _Initial;
    const factory DeleteEventState.loading() = _Loading;
  const factory DeleteEventState.success() = _Sucess;
  const factory DeleteEventState.error({required String message}) = _Error;

}
