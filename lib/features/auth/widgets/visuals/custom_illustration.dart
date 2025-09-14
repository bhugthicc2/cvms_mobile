import 'package:flutter/material.dart';

class CustomIllustration extends StatelessWidget {
  final String image;
  const CustomIllustration({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, fit: BoxFit.cover);
  }
}
