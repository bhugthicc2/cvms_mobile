import 'package:flutter/material.dart';
import 'app_font_sizes.dart';

class AppTextTheme {
  static TextTheme get light => TextTheme(
    // Labels
    labelSmall: TextStyle(
      fontSize: AppFontSizes.caption,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelMedium: TextStyle(
      fontSize: AppFontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
    ),
    labelLarge: TextStyle(
      fontSize: AppFontSizes.labelLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),

    // Body text
    bodySmall: TextStyle(
      fontSize: AppFontSizes.bodySmall,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: AppFontSizes.bodyMedium,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: AppFontSizes.bodyLarge,
      fontWeight: FontWeight.w500,
    ),

    // Titles
    titleSmall: TextStyle(
      fontSize: AppFontSizes.titleSmall,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: AppFontSizes.titleMedium,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontSize: AppFontSizes.titleLarge,
      fontWeight: FontWeight.w700,
    ),

    // Headlines
    headlineSmall: TextStyle(
      fontSize: AppFontSizes.headlineSmall,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: AppFontSizes.headlineMedium,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: AppFontSizes.headlineLarge,
      fontWeight: FontWeight.bold,
    ),

    // Display / Hero text
    displaySmall: TextStyle(
      fontSize: AppFontSizes.displaySmall,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      fontSize: AppFontSizes.displayMedium,
      fontWeight: FontWeight.w700,
    ),
    displayLarge: TextStyle(
      fontSize: AppFontSizes.displayLarge,
      fontWeight: FontWeight.w700,
    ),
  );

  /// You can also create a dark theme if needed:
  static TextTheme get dark =>
      light.apply(bodyColor: Colors.white, displayColor: Colors.white);
}
