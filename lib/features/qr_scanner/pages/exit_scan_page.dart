import 'dart:async';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/qr_scanner/bloc/vehicle_scan_cubit.dart';
import 'package:cvms_mobile/features/qr_scanner/bloc/vehicle_scan_state.dart';
import 'package:cvms_mobile/features/qr_scanner/data/vehicle_repository.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExitScanPage extends StatelessWidget {
  const ExitScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleRepo = VehicleRepository();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final currentUser =
            context.read<AuthCubit>().state is AuthAuthenticated
                ? (context.read<AuthCubit>().state as AuthAuthenticated).user
                : null;
        return BlocProvider(
          create: (_) => VehicleScanCubit(vehicleRepo),
          child: BlocConsumer<VehicleScanCubit, VehicleScanState>(
            listener: (context, state) {
              if (state is VehicleScanSuccess) {
                BannerToast.show(
                  context,
                  message: state.message,
                  type: BannerToastType.success,
                );
              } else if (state is VehicleScanError) {
                BannerToast.show(
                  context,
                  message: state.error,
                  type: BannerToastType.error,
                );
              }
            },
            builder: (context, state) {
              final scanCubit = context.read<VehicleScanCubit>();
              return QrScannerPage(
                isExit: true,
                pageTitle: 'Scan Exit QR',
                instructionText:
                    "Position the QR Code within the frame \n to scan for exit",
                onScan: (qrValue) async {
                  // Create a completer to wait for the cubit state change
                  final completer = Completer<bool>();

                  // Listen to the cubit state changes
                  late StreamSubscription subscription;
                  subscription = scanCubit.stream.listen((state) {
                    if (state is VehicleScanSuccess) {
                      subscription.cancel();
                      completer.complete(true);
                    } else if (state is VehicleScanError) {
                      subscription.cancel();
                      completer.complete(false);
                    }
                  });

                  // Start the scan process
                  try {
                    await scanCubit.processExitScan(
                      qrValue,
                      currentUser?.fullname ?? AppStrings.securityPersonnel,
                    );
                  } catch (e) {
                    subscription.cancel();
                    return false;
                  }

                  // Wait for the result from the stream
                  return await completer.future;
                },
              );
            },
          ),
        );
      },
    );
  }
}
