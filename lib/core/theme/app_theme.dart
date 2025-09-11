import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme({double textScaleFactor = 1.0}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E88E5),
    );
    final base = ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      useMaterial3: true,
    );
    final sora = GoogleFonts.soraTextTheme(base.textTheme);
    return base.copyWith(textTheme: sora);
  }

  static ThemeData darkTheme({double textScaleFactor = 1.0}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E88E5),
      brightness: Brightness.dark,
    );
    final base = ThemeData(
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardColor: const Color(0xFF121212),
      useMaterial3: true,
    );
    final sora = GoogleFonts.soraTextTheme(base.textTheme);
    return base.copyWith(textTheme: sora);
  }
}
