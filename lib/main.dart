import 'package:chat_server_mechine_test/utils/constants.dart';
import 'package:chat_server_mechine_test/firebase_options.dart';
import 'package:chat_server_mechine_test/hhh.dart';
import 'package:chat_server_mechine_test/view/screens/home.dart';
import 'package:chat_server_mechine_test/view/screens/login_screen.dart';
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
          textTheme: const TextTheme(bodyMedium: TextStyle(color: constants.white))),
      debugShowCheckedModeBanner: false,
      home: const signinwrapper(),
    );
  }
}
