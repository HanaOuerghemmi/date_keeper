import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_keeper/core/network/network_info.dart';
import 'package:date_keeper/features/auth/auth_injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);

  // await userInjectionContainer();
  // await chatInjectionContainer();
  // await statusInjectionContainer();
  // await callInjectionContainer();

  // Register PocketBase client
  //sl.registerLazySingleton(() => PocketBase('http://127.0.0.1:8090'));
  // sl.registerLazySingleton(() =>
  //     PocketBase('http://10.0.2.2:8090')); // this is  for emulator android ...

  //? CORE
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //!  EXTERNAL NETWORK SHAREDPRED...
  //sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  // await postsInjectionContainer();
  await authInjectionContainer();
  // await profileInjectionContainer();
}
