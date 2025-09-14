import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/appbar/custom_app_bar.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/frame/qr_scanner_frame.dart';
import '../../bloc/qr_scanner_cubit.dart';
import '../../bloc/qr_scanner_state.dart';

class QrScannerPage extends StatelessWidget {
  final String pageTitle;
  final String instructionText;
  final ValueChanged<String> onScan;
  final bool isExit;

  const QrScannerPage({
    super.key,
    required this.pageTitle,
    required this.instructionText,
    required this.onScan,
    this.isExit = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => QrScannerCubit(),
      child: BlocBuilder<QrScannerCubit, QrScannerState>(
        builder: (context, state) {
          final cubit = context.read<QrScannerCubit>();

          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              pageTitle: pageTitle,
              toggleTorch: cubit.toggleTorch,
              switchCam: cubit.switchCamera,
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: MobileScanner(
                    controller: cubit.controller,
                    onDetect: (capture) => cubit.onDetect(capture, onScan),
                    fit: BoxFit.cover,
                  ),
                ),

                // Scanner frame w/ feedback color
                CustomPaint(
                  size: screenSize,
                  painter: QrScannerFramePainter(frameColor: state.frameColor),
                ),

                // Instctn txt
                Positioned(
                  bottom: screenSize.height * 0.06,
                  left: 24,
                  right: 24,
                  child: Text(
                    instructionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.6),
                      fontSize: AppFontSizes.bodySmall,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
