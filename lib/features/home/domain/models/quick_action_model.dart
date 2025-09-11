import 'package:flutter/material.dart';

class QuickActionModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  // Optional asset-based icon for custom logos
  final String? iconAsset;

  const QuickActionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.iconAsset,
  });
}
