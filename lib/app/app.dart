import 'package:flutter/material.dart';
import 'package:cvms_mobile/core/routes/app_router.dart';
import 'package:cvms_mobile/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVMS',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
