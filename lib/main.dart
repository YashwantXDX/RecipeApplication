import 'package:flutter/material.dart';
import 'package:recipe_application/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins-Medium",
      ),
      title: "Recipe Application",
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
