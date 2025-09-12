import 'package:cvms_mobile/core/theme/app_theme.dart';
import 'package:cvms_mobile/features/auth/pages/splash_page.dart';
import 'package:flutter/material.dart';

class CVMSApp extends StatelessWidget {
  const CVMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}
