import 'package:flutter/material.dart';
import 'package:cvms_mobile/features/splash/presentation/pages/splash_page.dart';
import 'package:cvms_mobile/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
