import 'package:flutter/material.dart';
import 'package:uts/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Unsoed App CRUD',
      home: SplashScreen(),
    );
  }
}
