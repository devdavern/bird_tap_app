import 'package:flutter/material.dart';
import 'package:bird_tap_app/ui/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF0d47a1,
          {
            50: Color(0xFF0d47a1),
            100: Color(0xFF0d47a1),
            200: Color(0xFF0d47a1),
            300: Color(0xFF0d47a1),
            400: Color(0xFF0d47a1),
            500: Color(0xFF0d47a1),
            600: Color(0xFF0d47a1),
            700: Color(0xFF0d47a1),
            800: Color(0xFF0d47a1),
            900: Color(0xFF0d47a1),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
