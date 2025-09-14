import 'package:cvms_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(pageTitle: 'About'),
      body: SingleChildScrollView(),
    );
  }
}
