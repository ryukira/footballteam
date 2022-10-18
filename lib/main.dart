import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF0F4F1),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFF9F9F9)),
      ),
      home: const HomeScreen(),
    );
  }
}
