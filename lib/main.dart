import 'package:f_trivia/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(
          31,
          31,
          31,
          1.0,
        ),
        fontFamily: 'PlaypenSans',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
