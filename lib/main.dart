import 'package:be_talent_alex_challengue/pages/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be Talent App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFF0500FF),
          useMaterial3: true,
          fontFamily: 'Helvetica',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: 20,
                color: const Color(0xFF1C1C1C),
                fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(
                fontSize: 16,
                color: const Color(0xFF1C1C1C),
                fontWeight: FontWeight.w500),
            headlineSmall: TextStyle(
                fontSize: 16,
                color: const Color(0xFF1C1C1C),
                fontWeight: FontWeight.w400),
          )),
      home: InitialScreen(client: http.Client()),
    );
  }
}
