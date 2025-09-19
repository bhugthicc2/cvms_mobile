import 'dart:async';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum BannerToastType { success, error, info }

class BannerToast {
  static void show(
    BuildContext context, {
    required String message,
    BannerToastType type = BannerToastType.success,
    Duration duration = const Duration(seconds: 3),
    bool showClose = true,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    final _BannerStyle style = _mapTypeToStyle(type);

    var isRemoved = false;
    void safeRemove() {
      if (!isRemoved) {
        isRemoved = true;
        entry.remove();
      }
    }

    entry = OverlayEntry(
      builder:
          (context) => _BannerToastWidget(
            message: message,
            backgroundColor: style.backgroundColor,
            icon: style.icon,
            showClose: showClose,
            onClose: safeRemove,
          ),
    );

    overlay.insert(entry);
    Timer(duration, safeRemove);
  }

  static _BannerStyle _mapTypeToStyle(BannerToastType type) {
    switch (type) {
      case BannerToastType.success:
        return _BannerStyle(
          backgroundColor: AppColors.success,
          icon: PhosphorIconsFill.checkCircle,
        );
      case BannerToastType.error:
        return _BannerStyle(
          backgroundColor: AppColors.error,
          icon: PhosphorIconsFill.warningCircle,
        );
      case BannerToastType.info:
        return _BannerStyle(
          backgroundColor: AppColors.primary,
          icon: PhosphorIconsFill.info,
        );
    }
  }
}

class _BannerStyle {
  final Color backgroundColor;
  final IconData icon;
  const _BannerStyle({required this.backgroundColor, required this.icon});
}

class _BannerToastWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;
  final bool showClose;
  final VoidCallback? onClose;

  const _BannerToastWidget({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    this.showClose = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey500.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.white),
              AppSpacing.hSm,
              Expanded(
                child: Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: AppFontSizes.bodySmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (showClose) ...[
                AppSpacing.hSm,
                InkWell(
                  onTap: onClose,
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      PhosphorIconsLight.x,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
