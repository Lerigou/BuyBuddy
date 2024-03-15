import 'package:flutter/material.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'LeagueSpartan'),
      debugShowCheckedModeBanner: false, // tira o indicador de debug do app
      home: IntroPage(),
    );
  }
}