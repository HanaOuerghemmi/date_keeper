import 'package:date_keeper/features/auth/data/datasources/remote_data_source/auth_remote_data_source_impl-firebase.dart';
import 'package:date_keeper/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';
import 'package:date_keeper/features/auth/domain/usecases/log_in.dart';
import 'package:date_keeper/features/auth/domain/usecases/sign_in_as_anoymous.dart';
import 'package:date_keeper/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:date_keeper/features/auth/domain/usecases/sign_up.dart';
import 'package:date_keeper/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_keeper/main_injection_container.dart';

Future<void> authInjectionContainer() async {
  // * BLOC OR CUBIT INJECTION

  sl.registerFactory<AuthBloc>(() => AuthBloc(
        signInUsercase: sl(),
        logInUsercase: sl(),
        signInAsAnoymousUsercase: sl(),
        signInWithGoogleUsercase: sl(),
      ));

  // * USE CASES INJECTION

  sl.registerLazySingleton<SignInUsercase>(
      () => SignInUsercase(authRepository: sl()));

  sl.registerLazySingleton<LogInUsercase>(
      () => LogInUsercase(authRepository: sl()));

  sl.registerLazySingleton<SignInAsAnoymousUsercase>(
      () => SignInAsAnoymousUsercase(authRepository: sl()));

  sl.registerLazySingleton<SignInWithGoogleUsercase>(
      () => SignInWithGoogleUsercase(authRepository: sl()));

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AuthRemoteDataSourceImpl>(
      () => AuthRemoteDataSourceImpl(
            auth: sl(),
            firebaseFirestore: sl(),
            googleSignIn: sl(),
          ));
}
