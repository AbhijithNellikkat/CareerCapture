import 'package:career_capture/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Capture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 112, 1, 1)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
