import 'package:flutter/material.dart';
import 'Screens/welcome_screen.dart';

void main() async
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(context)
  {
    return const MaterialApp
      (
      title: 'GPT Bot',
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}