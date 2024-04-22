import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Roboto',
  brightness: Brightness.light,
  primaryColor: const Color.fromRGBO(26, 115, 232, 1),
  primaryColorLight: const Color.fromARGB(255, 53, 140, 253),
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(240, 242, 245, 1),
    primary: Color.fromRGBO(26, 115, 232, 1),
    secondary: Color(0x007b809a),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      color: Color.fromARGB(255, 6, 25, 51),
    ),
  ),
  dataTableTheme: DataTableThemeData(
    headingTextStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    headingRowColor: MaterialStateProperty.resolveWith(
      (states) => lightMode.primaryColor,
    ),
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white,
  ),
  dividerTheme: const DividerThemeData(color: Colors.black12, thickness: 1),
);
