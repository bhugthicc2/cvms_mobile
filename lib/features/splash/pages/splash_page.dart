import 'dart:async';

import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_copywriter.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_sub_heading.dart';
import 'package:cvms_mobile/features/splash/widgets/visuals/custom_logo.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CustomLogo(logo: 'assets/images/jrmsu_logo.png'),
            AppSpacing.vSm,
            CustomHeading(heading: 'JRMSU - K'),
            CustomSubHeading(
              subheading: 'CLOUD-BASED VEHICLE MONITORING SYSTEM',
            ),
            Spacer(),
            CustomCopywriter(copywriter: '© CDRRMSU - KATIPUNAN, 2025'),
            AppSpacing.vSm,
          ],
        ),
      ),
    );
  }
}
