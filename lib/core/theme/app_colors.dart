import 'package:flutter/material.dart';

class AppColors {
  //brand
  static const Color primary = Color(0xFF1F5AF1);
  static const Color primaryYellow = Color(0xFFFFDE21);
  static const Color primaryDark = Color(0xFF163CB0);
  static const Color primaryLight = Color(0xFF4F7FF6);

  static const Color secondary = Color(0xFF1E1E1E);
  static const Color secondaryLight = Color(0xFF4B4B4B);
  //neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1E1E1E);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF2F4FA);
  static const Color grey200 = Color(0xFFEAECF0);
  static const Color grey300 = Color(0xFFBEC8ED);
  static const Color grey400 = Color(0xFF7E818D);
  static const Color grey500 = Color(0xFF4B5563);

  //feedback/status

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  //surface/bg
  static const Color backgroundLight = white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = grey100;
  static const Color surfaceDark = Color(0xFF1A1A1A);
  //chart colors
  static const Color chartOrange = Color(0xFFFB923C);
  static const Color chartGreen = Color(0xFF22C55E);
  static const Color chartBlue = Color(0xFF2563EB);
  static const Color chartPurple = Color(0xFFC084FC);
  //text
  static Color subheading = Color(0xFF1F2937).withValues(alpha: 0.50);
  //shadow
  static const Color shadow = Color(0xFFACACAC);

  //gradients
  static const Gradient greenWhite = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFF14B8A6), Color(0xFF53C6BA)],
  );

  static const Gradient yellowWhite = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFFF6A318), Color(0xFFF8B951)],
  );

  static const Gradient blueWhite = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFF1F5AF1), Color(0xFF5782F3)],
  );

  static const Gradient pinkWhite = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFFEC4899), Color(0xFFF285BA)],
  );
}
