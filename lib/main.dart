import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/user_cubit.dart';
import 'package:kick/data/api/database_api.dart';
import 'package:kick/data/api/user_api.dart';
import 'package:kick/data/services/user_service.dart';
import 'package:kick/start_page.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}
