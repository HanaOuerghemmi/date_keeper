import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/auth/domain/usecases/log_in.dart';
import 'package:date_keeper/features/auth/domain/usecases/sign_up.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsercase signInUsercase;
  final LogInUsercase logInUsercase;
  AuthBloc({
    required this.signInUsercase,
    required this.logInUsercase,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        createAccount: (userEntity) async {
          emit(const AuthState.loading());
          final failureOrCreate = await signInUsercase(userEntity);
          failureOrCreate.fold((failure) async {
            emit(const AuthState.error(
                message: "error")); //_mapFailureToMessage(failure)
          }, (user) async {
            add(AuthEvent.logIn(userEntity: userEntity));
          });
        },
        logIn: (userEntity) async {
          emit(const AuthState.loading());
          final failureOrCreate = await logInUsercase(userEntity);
          failureOrCreate.fold((failure) async {
            emit(const AuthState.error(
                message: "error")); //_mapFailureToMessage(failure)
          }, (user) async {
            emit(AuthState.loaded(userEntity: user));
          });
        },
      );
    });
  }
}
