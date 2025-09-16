import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_font_sizes.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get light {
    final base = GoogleFonts.soraTextTheme(ThemeData.light().textTheme);

    return base.copyWith(
      // Labels
      labelSmall: base.labelSmall?.copyWith(
        fontSize: AppFontSizes.caption,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: AppFontSizes.labelSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: AppFontSizes.labelLarge,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),

      // Body text
      bodySmall: base.bodySmall?.copyWith(
        fontSize: AppFontSizes.bodySmall,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: AppFontSizes.bodyMedium,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: AppFontSizes.bodyLarge,
        fontWeight: FontWeight.w500,
      ),

      // Titles
      titleSmall: base.titleSmall?.copyWith(
        fontSize: AppFontSizes.titleSmall,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: AppFontSizes.titleMedium,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: AppFontSizes.titleLarge,
        fontWeight: FontWeight.w700,
      ),

      // Headlines
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: AppFontSizes.headlineSmall,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: AppFontSizes.headlineMedium,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: AppFontSizes.headlineLarge,
        fontWeight: FontWeight.bold,
      ),

      // Display / Hero text
      displaySmall: base.displaySmall?.copyWith(
        fontSize: AppFontSizes.displaySmall,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: AppFontSizes.displayMedium,
        fontWeight: FontWeight.w700,
      ),
      displayLarge: base.displayLarge?.copyWith(
        fontSize: AppFontSizes.displayLarge,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static TextTheme get dark =>
      light.apply(bodyColor: Colors.white, displayColor: Colors.white);
}
