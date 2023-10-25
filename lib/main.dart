import 'package:droptel/Model/Mongodb.dart';
import 'package:droptel/Theme/theme.dart';
import 'package:droptel/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Mongodb.connect();
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
