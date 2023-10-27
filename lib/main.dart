import 'package:flutter/material.dart';
import './screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color.fromRGBO(26, 115, 232, 1),
          useMaterial3: true,
        ),
        home: const LoginScreen());
  }
}
