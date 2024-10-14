part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.createAccount({required UserEntity userEntity}) =
      _CreateAccount;
  const factory AuthEvent.logIn({required UserEntity userEntity}) = _LogIn;
}
