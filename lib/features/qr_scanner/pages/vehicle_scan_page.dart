import 'dart:async';
import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:cvms_mobile/features/qr_scanner/bloc/vehicle_scan_state.dart';
import 'package:cvms_mobile/features/qr_scanner/data/vehicle_repository.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:cvms_mobile/features/qr_scanner/bloc/vehicle_scan_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleScanPage extends StatelessWidget {
  const VehicleScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleRepo = VehicleRepository();
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
          } else if (state is VehicleRetrieved) {
            Navigator.pushNamed(
              context,
              AppRoutes.vehicleInfo,
              arguments: state.vehicle,
            );
          }
        },

        builder: (context, state) {
          final scanCubit = context.read<VehicleScanCubit>();
          return QrScannerPage(
            pageTitle: 'Scan Vehicle QR',
            instructionText:
                "Position the QR Code within the frame \n to scan for vehicle ID",
            stopOnSuccess: true, //gidungag gabie
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
                } else if (state is VehicleRetrieved) {
                  subscription.cancel();
                  completer.complete(true);
                }
              });

              // Start retrieval process
              try {
                await scanCubit.getVehicleById(qrValue);
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
  }
}
