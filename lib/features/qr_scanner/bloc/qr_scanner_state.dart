import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';

class QrScannerState extends Equatable {
  final bool isProcessing;
  final String? lastScannedValue;
  final Color frameColor;
  final bool torchEnabled;
  final bool usingFrontCamera;
  final String? message;

  const QrScannerState({
    this.isProcessing = false,
    this.lastScannedValue,
    this.frameColor = AppColors.primary,
    this.torchEnabled = false,
    this.usingFrontCamera = false,
    this.message,
  });

  QrScannerState copyWith({
    bool? isProcessing,
    String? lastScannedValue,
    Color? frameColor,
    bool? torchEnabled,
    bool? usingFrontCamera,
    String? message,
  }) {
    return QrScannerState(
      isProcessing: isProcessing ?? this.isProcessing,
      lastScannedValue: lastScannedValue ?? this.lastScannedValue,
      frameColor: frameColor ?? this.frameColor,
      torchEnabled: torchEnabled ?? this.torchEnabled,
      usingFrontCamera: usingFrontCamera ?? this.usingFrontCamera,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    isProcessing,
    lastScannedValue,
    frameColor,
    torchEnabled,
    usingFrontCamera,
    message,
  ];
}
