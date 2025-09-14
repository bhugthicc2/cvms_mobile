import 'package:cvms_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(pageTitle: 'Settings'),
      body: SingleChildScrollView(),
    );
  }
}
