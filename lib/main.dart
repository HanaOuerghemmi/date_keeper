import 'package:date_keeper/core/bloc_observer/cubit_observer.dart';
import 'package:date_keeper/core/rooting/app_rooting.dart';
import 'package:date_keeper/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:date_keeper/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_keeper/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:date_keeper/features/character/presentation/bloc/character_bloc.dart';
import 'package:date_keeper/features/character/presentation/cubit/delete_character_cubit/delete_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/cubit/get_all_character/get_all_character_cubit.dart';
import 'package:date_keeper/features/character/presentation/cubit/update_character_cubit/update_character_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/create_event_cubit/create_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/delete_event_cubit/delete_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/get_all_event_cubit/getall_event_cubit.dart';
import 'package:date_keeper/features/event/presentation/bloc/update_event_cubit/update_event_cubit.dart';
import 'package:date_keeper/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_injection_container.dart' as di;

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final AppRouter _appRouter = AppRouter(); // Create instance of AppRouter

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetAllCharacterCubit>(),
        ),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
     //********* Character bloc **********/

        
        BlocProvider(create: (_) => di.sl<CharacterBloc>()),
        BlocProvider(create: (_) => di.sl<DeleteCharacterCubit>()),
        BlocProvider(create: (_) => di.sl<UpdateCharacterCubit>()),


        //********* event bloc **********/
        BlocProvider(create: (_) => di.sl<CreateEventCubit>()),
        BlocProvider(create: (_) => di.sl<GetallEventCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteEventCubit>()),
        BlocProvider(create: (_) => di.sl<UpdateEventCubit>()),


      ],
      child: MaterialApp.router(
        title: 'date keeper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter().router,
      ),
    );
  }
}
