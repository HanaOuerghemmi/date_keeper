part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initialAuth() = InitialAuth;
  const factory AuthState.authenticated({required String uid}) = Authenticated;
  const factory AuthState.unAuthenticated() = UnAuthenticated;
}
