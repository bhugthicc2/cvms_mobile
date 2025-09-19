import 'dart:async';
import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_copywriter.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_sub_heading.dart';
import 'package:cvms_mobile/core/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkKeepLoggedIn();
    context.read<AuthCubit>().stream.listen((state) async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      if (state is AuthAuthenticated) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else if (state is AuthLoggedOut) {
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
            image: AssetImage('assets/images/splash_bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const CustomLogo(logo: 'assets/images/jrmsu_logo.webp', size: 130),
            AppSpacing.vSm,
            CustomHeading(heading: AppStrings.appName),
            CustomSubHeading(subheading: AppStrings.appInfo),
            const Spacer(),
            CustomCopywriter(copywriter: AppStrings.copyright),
            AppSpacing.vSm,
          ],
        ),
      ),
    );
  }
}
