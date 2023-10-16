import 'package:droptel/Theme/theme.dart';
import 'package:droptel/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropTel',
      theme: lightTheme,
      home: splash_screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
