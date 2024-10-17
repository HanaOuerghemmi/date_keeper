import 'package:date_keeper/features/character/data/datasources/remote_data_source/character_remote_data_source_impl.dart';
import 'package:date_keeper/features/character/data/repositories/character_repository_impl.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';
import 'package:date_keeper/features/character/domain/usecases/create_character.dart';
import 'package:date_keeper/features/character/presentation/bloc/character_bloc.dart';
import 'package:date_keeper/main_injection_container.dart';

Future<void> characterInjectionContainer() async {
  // * BLOC OR CUBIT INJECTION

  sl.registerFactory<CharacterBloc>(() => CharacterBloc(
        createCaracterUsercase: sl(),
      ));

  // * USE CASES INJECTION

  sl.registerLazySingleton<CreateCaracterUsercase>(
      () => CreateCaracterUsercase(characterRepository: sl()));

  // sl.registerLazySingleton<LogInUsercase>(
  //     () => LogInUsercase(authRepository: sl()));

  // sl.registerLazySingleton<SignInAsAnoymousUsercase>(
  //     () => SignInAsAnoymousUsercase(authRepository: sl()));

  // sl.registerLazySingleton<SignInWithGoogleUsercase>(
  //     () => SignInWithGoogleUsercase(authRepository: sl()));

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<CharacterRemoteDataSourceImpl>(
      () => CharacterRemoteDataSourceImpl(
            auth: sl(),
            firebaseFirestore: sl(),
            firebaseStorage: sl(),
          ));
}
