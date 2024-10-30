import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:date_keeper/features/event%20presentation/presentation/widgets/event_card_widget.dart';
import 'package:date_keeper/features/event/data/datasources/remote_data_source/event_remote_datasource_impl.dart';
import 'package:date_keeper/features/event/data/repositories/event_repository_impl.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';
import 'package:date_keeper/features/event/domain/usecases/creat_event_usescase.dart';
import 'package:date_keeper/features/event/presentation/bloc/create_event_cubit/create_event_cubit.dart';
import 'package:date_keeper/main_injection_container.dart';

Future<void> eventInjectionContainer () async{
//*********** bloc injection  ************/
sl.registerLazySingleton<CreateEventCubit>(()=> CreateEventCubit(
  creatEventUsescase: sl(),
  ));
//*********** uses cases injection  ***************/

 sl.registerLazySingleton<CreatEventUsescase>(
      () => CreatEventUsescase(eventRepository: sl()));



//*********** repository injection  *************/
  sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

//*********** data injection  *************/

  sl.registerLazySingleton<EventRemoteDatasourceImpl>(
      () => EventRemoteDatasourceImpl(
            auth: sl(),
            firebaseFirestore: sl(),
            firebaseStorage: sl(),
          ));
}