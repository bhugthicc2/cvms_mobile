import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const Color primaryBlue = Color(0xFF0B3AA4);
  const Color accentYellow = Color(0xFFF2C230);

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryBlue,
    primary: primaryBlue,
    secondary: accentYellow,
    brightness: Brightness.light,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        color: Colors.white70,
        letterSpacing: 0.5,
      ),
    ),
    useMaterial3: true,
  );
}
