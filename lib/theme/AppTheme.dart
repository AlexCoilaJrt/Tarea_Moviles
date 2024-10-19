import 'package:flutter/material.dart';

class AppTheme {
  static bool useMaterial3 = false;
  static bool useLightMode = true;
  static Color colorX = Colors.lightBlue; // Celeste predeterminado

  static int colorSelected = 0;
  static List<Color> colorOptions = [
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.redAccent,
  ];

  static List<String> colorText = [
    "Blue",
    "Purple",
    "Orange",
    "Green",
    "Red",
  ];

  static ThemeData themeData = ThemeData(
    colorSchemeSeed: colorOptions[colorSelected],
    useMaterial3: useMaterial3,
    brightness: useLightMode ? Brightness.light : Brightness.dark,
  );
}
