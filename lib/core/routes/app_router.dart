import 'package:flutter/material.dart';
import 'package:cvms_mobile/src/features/splash/presentation/pages/splash_page.dart';
import 'package:cvms_mobile/src/features/home/presentation/pages/home_page.dart';
import 'package:cvms_mobile/src/features/about/presentation/pages/about_page.dart';
import 'package:cvms_mobile/src/features/settings/presentation/pages/settings_page.dart';
import 'package:cvms_mobile/src/features/profile/presentation/pages/profile_page.dart';
import 'package:cvms_mobile/src/features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:cvms_mobile/src/features/forgot_password/presentation/pages/email_sent_page.dart';
import 'package:cvms_mobile/src/features/scanner/presentation/pages/scan_entrance_page.dart';
import 'package:cvms_mobile/src/features/scanner/presentation/pages/scan_exit_page.dart';
import 'package:cvms_mobile/src/features/scanner/presentation/pages/scan_vehicle_page.dart';
import 'package:cvms_mobile/src/features/recent_activity/presentation/pages/recent_activity_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String emailSent = '/email-sent';
  static const String scanEntrance = '/scan-entrance';
  static const String scanExit = '/scan-exit';
  static const String scanVehicle = '/scan-vehicle';
  static const String recentActivity = '/recent-activity';

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
      case scanEntrance:
        return MaterialPageRoute(builder: (_) => const ScanEntrancePage());
      case scanExit:
        return MaterialPageRoute(builder: (_) => const ScanExitPage());
      case scanVehicle:
        return MaterialPageRoute(builder: (_) => const ScanVehiclePage());
      case recentActivity:
        return MaterialPageRoute(builder: (_) => const RecentActivityPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
