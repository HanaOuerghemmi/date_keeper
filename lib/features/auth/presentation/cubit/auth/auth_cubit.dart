// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:date_keeper/features/auth/domain/usecases/log_out.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:date_keeper/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:date_keeper/features/auth/domain/usecases/is_sign_in_usecase.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final LogOutUsercase logOutUsercase;
  AuthCubit({
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
    required this.logOutUsercase,
  }) : super(const AuthState.initialAuth());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase();
      isSignIn.fold((failure) async {
        emit(const AuthState.unAuthenticated()); //_mapFailureToMessage(failure)
      }, (isSignIn) async {
        final uid = await getCurrentUidUseCase.call();
        uid.fold((failure) async {
          emit(const AuthState
              .unAuthenticated()); //_mapFailureToMessage(failure)
        }, (uid) {
          emit(AuthState.authenticated(uid: uid));
        });
      }
          // else {
          //   emit(const AuthState.unAuthenticated());
          // }
          );

      // if (isSignIn) {
      //   final uid = await getCurrentUidUseCase.call();
      //   emit(AuthState.authenticated(uid: uid));
      // } else {
      //   emit(const AuthState.unAuthenticated());
      // }
    } catch (_) {
      emit(const AuthState.unAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase();
      uid.fold((failure) async {
        emit(const AuthState.unAuthenticated()); //_mapFailureToMessage(failure)
      }, (uid) {
        log(uid);
        emit(AuthState.authenticated(uid: uid));
      });
    } catch (_) {
      emit(const AuthState.unAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await logOutUsercase();
      emit(const AuthState.unAuthenticated());
    } catch (_) {
      emit(const AuthState.unAuthenticated());
    }
  }
}
