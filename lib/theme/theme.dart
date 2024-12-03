import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade50,
    onSurface: Colors.black,
    primary: Colors.indigoAccent,
    secondary: Colors.black,
    tertiary: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    onSurface: Colors.white,
    primary: Colors.indigoAccent,
    secondary: Colors.white,
    tertiary: Colors.black,
  ),
);
