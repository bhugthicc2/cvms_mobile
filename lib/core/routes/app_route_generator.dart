import 'package:cvms_mobile/features/activity/pages/recent_activity_page.dart';
import 'package:cvms_mobile/features/auth/pages/email_sent_page.dart';
import 'package:cvms_mobile/features/auth/pages/forgot_password_page.dart';
import 'package:cvms_mobile/features/profile/pages/profile_page.dart';
import 'package:cvms_mobile/features/qr_scanner/pages/entrance_scan_page.dart';
import 'package:cvms_mobile/features/home/pages/home_page.dart';
import 'package:cvms_mobile/features/qr_scanner/pages/exit_scan_page.dart';
import 'package:cvms_mobile/features/qr_scanner/pages/vehicle_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:cvms_mobile/features/splash/pages/splash_page.dart';
import 'package:cvms_mobile/features/auth/pages/login_page.dart';
import 'app_routes.dart';

class AppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.forgotPass:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case AppRoutes.emailSent:
        return MaterialPageRoute(builder: (_) => const EmailSentPage());
      case AppRoutes.entryScan:
        return MaterialPageRoute(builder: (_) => const EntranceScanPage());
      case AppRoutes.exitScan:
        return MaterialPageRoute(builder: (_) => const ExitScanPage());
      case AppRoutes.vehicleScan:
        return MaterialPageRoute(builder: (_) => const VehicleScanPage());
      case AppRoutes.recentActivity:
        return MaterialPageRoute(builder: (_) => const RecentActivityPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }
}
