import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/game_cubit/game_cubit.dart';
import 'package:kick/cubit/user_cubit/user_cubit.dart';
import 'package:kick/data/api/database_api.dart';
import 'package:kick/data/api/user_api.dart';
import 'package:kick/data/services/user_service.dart';
import 'package:kick/pages/game_page.dart';
import 'package:kick/pages/start_page.dart';
import 'package:provider/provider.dart';

void main() {
  DatabaseApi _databaseApi = DatabaseApi();

  UserService userService = UserService(UserApi(_databaseApi));

  runApp(
    MultiProvider(
      providers: [
        Provider<UserService>(create: (context) => userService),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(context),
        ),
        BlocProvider<GameCubit>(
          create: (context) => GameCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state is GameInitialState) {
            BlocProvider.of<GameCubit>(context).initGame();
          } else if (state is GameScreenState) {
            return const GamePage();
          } else if (state is StartScreenState) {
            return const StartPage();
          }
          return Container();
        },
      ),
    );
  }
}
