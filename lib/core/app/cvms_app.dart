import 'package:cvms_mobile/core/routes/app_route_generator.dart';
import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CVMSApp extends StatelessWidget {
  const CVMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouteGenerator.generateRoute,
    );
  }
}
