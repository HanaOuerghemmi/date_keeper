import 'package:date_keeper/features/event/data/datasources/remote_data_source/event_remote_datasource_impl.dart';
import 'package:date_keeper/features/event/data/repositories/event_repository_impl.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';
import 'package:date_keeper/features/event/domain/usecases/creat_event_usescase.dart';
import 'package:date_keeper/features/event/domain/usecases/delte_event_usecase.dart';
import 'package:date_keeper/features/event/domain/usecases/getall_event_usecase.dart';
import 'package:date_keeper/features/event/domain/usecases/update_event_usecas.dart';
import 'package:date_keeper/features/event/presentation/bloc/create_event_cubit/create_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/delete_event_cubit/delete_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_cubit/getall_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/update_event_cubit/update_event_cubit.dart';
import 'package:date_keeper/main_injection_container.dart';

Future<void> eventInjectionContainer() async {
//************************** bloc injection  ************/
  sl.registerLazySingleton<CreateEventCubit>(() => CreateEventCubit(
        creatEventUsescase: sl(),
      ));
  sl.registerLazySingleton<GetallEventCubit>(() => GetallEventCubit(
        getAllEventUsecase: sl(),
      ));
  sl.registerLazySingleton<DeleteEventCubit>(() => DeleteEventCubit(
        deleteEventUsecase: sl(),
      ));
  sl.registerLazySingleton<UpdateEventCubit>(() => UpdateEventCubit(
        updateEventUsecase: sl(),
      ));

//************************** uses cases injection  ***************/

  sl.registerLazySingleton<CreatEventUsescase>(
      () => CreatEventUsescase(eventRepository: sl()));

  sl.registerLazySingleton<GetAllEventUsecase>(
      () => GetAllEventUsecase(eventRepository: sl()));
  sl.registerLazySingleton<DeleteEventUsecase>(
      () => DeleteEventUsecase(eventRepository: sl()));
  sl.registerLazySingleton<UpdateEventUsecase>(
      () => UpdateEventUsecase(eventRepository: sl()));

//************************** repository injection  *************/
  sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

//************************** data injection  *************/

  sl.registerLazySingleton<EventRemoteDatasourceImpl>(
      () => EventRemoteDatasourceImpl(
            auth: sl(),
            firebaseFirestore: sl(),
            firebaseStorage: sl(),
          ));
}
