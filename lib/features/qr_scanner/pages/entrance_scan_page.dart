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

class EntranceScanPage extends StatelessWidget {
  const EntranceScanPage({super.key});

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
                isExit: false,
                pageTitle: 'Scan Entry QR',
                instructionText:
                    "Position the QR Code within the frame \n to scan for entry",
                onScan: (qrValue) async {
                  // 3 Calling onScanAsync with qrValue
                  // Create a completer to wait for the cubit state change
                  final completer = Completer<bool>();
                  // Listen to the cubit state changes
                  late StreamSubscription subscription;
                  // 4 stream subscription set
                  subscription = scanCubit.stream.listen((state) {
                    // 11 Cubit state changed to: VehicleScanLoading
                    // 23 Cubit state changed to: VehicleScanSuccess
                    if (state is VehicleScanSuccess) {
                      // 24 scan successful returing true
                      subscription.cancel();
                      completer.complete(true);
                    } else if (state is VehicleScanError) {
                      subscription.cancel();
                      completer.complete(false);
                    } else {
                      //12 Intermediate state: VehicleScanLoading
                    }
                  });
                  // Start the scan process
                  try {
                    //5 calling process scan
                    //talks to Firestore and updates vehicle/vehicle_logs.
                    await scanCubit.processEntryScan(
                      qrValue,
                      currentUser?.fullname ?? AppStrings.securityPersonnel,
                    );
                    // 21 processEntryScan completed without exception
                  } catch (e) {
                    subscription.cancel();
                    return false;
                  }
                  // 22 Wait for the result from the stream
                  //pauses until the cubit emits either success or error.
                  final result = await completer.future;
                  //25 stream returned true

                  return result;
                },
              );
            },
          ),
        );
      },
    );
  }
}
