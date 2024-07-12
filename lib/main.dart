import 'package:chat_server_mechine_test/constants.dart';
import 'package:chat_server_mechine_test/firebase_options.dart';
import 'package:chat_server_mechine_test/hhh.dart';
import 'package:chat_server_mechine_test/home.dart';
import 'package:chat_server_mechine_test/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
             
              foregroundColor: constants.white),
          scaffoldBackgroundColor: constants.backgroundColor,
          textTheme: TextTheme(bodyMedium: TextStyle(color: constants.white))),
      debugShowCheckedModeBanner: false,
      home: HomeScreenwrapper(),
    );
  }
}
