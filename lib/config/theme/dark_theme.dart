import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  fontFamily: 'Roboto',
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(26, 115, 232, 1),
  primaryColorLight: const Color.fromARGB(255, 104, 155, 221),
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(26, 32, 53, 1),
    primary: Color.fromRGBO(26, 115, 232, 1),
    secondary: Color(0x007b809a),
  ),
);
