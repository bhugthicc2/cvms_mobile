import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF1E3A8A), // Deep royal blue to match the image
        ),
        child: Stack(
          children: [
            // Background image overlay with statue positioned in lower left
            Positioned.fill(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Splash Screen.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomLeft,
                    colorFilter: ColorFilter.mode(
                      Color(0x40000000), // Dark overlay to make text readable
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
            // Main content - Centered
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // JRMSU Logo - Clean design without color circles
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/jrmsu.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // JRMSU - K text - Bright yellow as in the image
                  Text(
                    'JRMSU - K',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFD700), // Bright yellow
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // CLOUD-BASED VEHICLE MONITORING SYSTEM text - Single line
                  Text(
                    'CLOUD-BASED VEHICLE MONITORING SYSTEM',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            // Copyright text at the bottom
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Text(
                '© CDRRMSU - KATIPUNAN, 2025',
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
