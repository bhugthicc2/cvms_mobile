import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/appbar/custom_app_bar.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/frame/qr_scanner_frame.dart';
import '../../bloc/qr_scanner_cubit.dart';
import '../../bloc/qr_scanner_state.dart';
import 'package:cvms_mobile/core/routes/route_observer.dart';

class QrScannerPage extends StatefulWidget {
  final String pageTitle;
  final String instructionText;
  final Future<bool> Function(String) onScan;
  final bool isExit;
  final bool stopOnSuccess; //gidungag gabie

  const QrScannerPage({
    super.key,
    required this.pageTitle,
    required this.instructionText,
    required this.onScan,
    this.isExit = false,
    this.stopOnSuccess = false, //gidungag gabie
  });

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

//gidungag gabie
class _QrScannerPageState extends State<QrScannerPage> with RouteAware {
  QrScannerCubit? _localCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  // Called when coming back to this page (e.g., after popping VehicleInfoPage)
  @override
  void didPopNext() {
    // restart camera only if this page is configured to stop on success
    if (widget.stopOnSuccess && _localCubit != null) {
      try {
        _localCubit!.controller.start();
      } catch (_) {}
    }
  }

  //gidungag gabie
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => QrScannerCubit(),
      child: BlocBuilder<QrScannerCubit, QrScannerState>(
        builder: (context, state) {
          _localCubit ??= context.read<QrScannerCubit>();
          final cubit = _localCubit!;

          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              pageTitle: widget.pageTitle,
              toggleTorch: cubit.toggleTorch,
              switchCam: cubit.switchCamera,
              isTorchOn: state.torchEnabled,
              isFrontCamera: state.usingFrontCamera,
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: MobileScanner(
                    //mobile scanner controller - controls the qr scanner like start/stop etc.
                    controller: cubit.controller,
                    // 0 calls ondetect to read qr code data and decide what to do with it
                    //onDetect: (capture) => cubit.onDetect(capture, onScan), ----gitangtang gabie
                    onDetect:
                        (capture) => cubit.onDetect(capture, (value) async {
                          final result = await widget.onScan(value);
                          if (result && widget.stopOnSuccess) {
                            try {
                              await cubit.controller.stop();
                            } catch (_) {}
                          }
                          return result;
                        }),
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
                    widget.instructionText,
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
