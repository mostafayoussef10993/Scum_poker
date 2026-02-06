import 'package:flutter/material.dart';

class FontTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: Colors.white70,
      fontWeight: FontWeight.bold,
    ),
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    scaffoldBackgroundColor: Colors.transparent,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
    scaffoldBackgroundColor: Colors.transparent,
  );
}
