Future<void> characterInjectionContainer() async {
  // * BLOC OR CUBIT INJECTION

  // sl.registerFactory<AuthBloc>(() => AuthBloc(
  //       signInUsercase: sl(),
  //       logInUsercase: sl(),
  //       signInAsAnoymousUsercase: sl(),
  //       signInWithGoogleUsercase: sl(),
  //     ));

  // * USE CASES INJECTION

  // sl.registerLazySingleton<SignInUsercase>(
  //     () => SignInUsercase(authRepository: sl()));

  // sl.registerLazySingleton<LogInUsercase>(
  //     () => LogInUsercase(authRepository: sl()));

  // sl.registerLazySingleton<SignInAsAnoymousUsercase>(
  //     () => SignInAsAnoymousUsercase(authRepository: sl()));

  // sl.registerLazySingleton<SignInWithGoogleUsercase>(
  //     () => SignInWithGoogleUsercase(authRepository: sl()));

  // * REPOSITORY & DATA SOURCES INJECTION
  // sl.registerLazySingleton<AuthRepository>(
  //     () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // sl.registerLazySingleton<AuthRemoteDataSourceImpl>(
  //     () => AuthRemoteDataSourceImpl(
  //           auth: sl(),
  //           firebaseFirestore: sl(),
  //           googleSignIn: sl(),
  //         ));
}
