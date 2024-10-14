part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.loaded({required UserEntity userEntity}) = Loaded;
  const factory AuthState.error({required String message}) = Error;
}
