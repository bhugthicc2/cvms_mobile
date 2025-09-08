import 'package:flutter/material.dart';
import 'package:cvms_mobile/src/features/splash/presentation/pages/splash_page.dart';
import 'package:cvms_mobile/src/features/home/presentation/pages/home_page.dart';
import 'package:cvms_mobile/src/features/about/presentation/pages/about_page.dart';
import 'package:cvms_mobile/src/features/settings/presentation/pages/settings_page.dart';
import 'package:cvms_mobile/src/features/profile/presentation/pages/profile_page.dart';
import 'package:cvms_mobile/src/features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:cvms_mobile/src/features/forgot_password/presentation/pages/email_sent_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String emailSent = '/email-sent';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case emailSent:
        return MaterialPageRoute(builder: (_) => const EmailSentPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
