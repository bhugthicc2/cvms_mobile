import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String? logo;
  final int size;
  const CustomLogo({super.key, this.logo, required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logo ?? 'assets/images/jrmsu_logo.webp',
      cacheHeight: size,
      cacheWidth: size,
      fit: BoxFit.cover,
    );
  }
}
