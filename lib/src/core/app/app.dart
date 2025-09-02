import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class CVMSApp extends StatelessWidget {
  const CVMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JRMSU - K',
      theme: buildAppTheme(),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
