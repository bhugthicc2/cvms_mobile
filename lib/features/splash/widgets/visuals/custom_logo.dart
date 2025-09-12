import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String logo;
  const CustomLogo({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Image.asset(logo, height: 150, width: 150, fit: BoxFit.cover);
  }
}
