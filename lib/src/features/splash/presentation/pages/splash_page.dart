import 'dart:async';

import 'package:flutter/material.dart';

import '../../../login/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _minimumDisplayTime = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    unawaited(_goNext());
  }

  Future<void> _goNext() async {
    await Future<void>.delayed(_minimumDisplayTime);
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Adjustable background image
          Positioned.fill(
            child: Image.asset(
              'assets/splash bg.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          // Foreground content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(height: 32),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // University seal
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: Image.asset(
                        'assets/jrmsu.png',
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'JRMSU - K',
                      style: textTheme.titleLarge?.copyWith(
                        color: const Color(0xFFF2C230),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sora',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CLOUD-BASED VEHICLE MONITORING SYSTEM',
                      style: textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    '© CDRRMSU - KATIPUNAN, 2025',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
