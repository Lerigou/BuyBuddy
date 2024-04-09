import 'package:buy_buddy_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'pages/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'LeagueSpartan'),
      debugShowCheckedModeBanner: false, // tira o indicador de debug do app
      home: LoginPage(),
    );
  }
}