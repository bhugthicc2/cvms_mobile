import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/utils/bottom_sheet_utils.dart';
import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_dropdown_field.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/qr_scanner/bloc/violation_cubit.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/cards/custom_plate_section.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/cards/info_section_factory.dart';
import 'package:cvms_mobile/features/qr_scanner/models/info_section_data.dart';
import 'package:cvms_mobile/features/qr_scanner/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/widgets/custom_app_bar.dart';

class VehicleInfoPage extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleInfoPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.28;
    final studentInfo = StudentInfoData(
      schoolId: vehicle.schoolID,
      fullname: vehicle.ownerName,
      gender: vehicle.gender,
      course: vehicle.department,
      yearLevel: vehicle.yearLevel,
      block: vehicle.block,
      contact: vehicle.contact,
    );

    final addressInfo = AddressData(
      purok: vehicle.purok,
      barangay: vehicle.barangay,
      cityMunicipality: vehicle.city,
      province: vehicle.province,
    );

    final vehicleDetails = VehicleDetailsData(
      plateNumber: vehicle.plateNumber,
      model: vehicle.vehicleModel,
      color: vehicle.vehicleColor,
    );
    final List<String> violationTypes = [
      'Parking Violation',
      'Speed Violation',
      'No Valid Registration',
      'No Valid License',
      'Reckless Driving',
      'Unauthorized Entry',
      'Improper Parking',
      'Vehicle Modification',
      'Other',
    ];
    final currentUser =
        context.read<AuthCubit>().state is AuthAuthenticated
            ? (context.read<AuthCubit>().state as AuthAuthenticated).user
            : null;

    void showReportBottomSheet(BuildContext ctx) {
      String? selectedViolation = 'Parking Violation';
      final TextEditingController otherController = TextEditingController();

      showCustomBottomSheet(
        context: ctx,
        title: 'Report Vehicle',
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Please specify the issue...'),
                AppSpacing.vMd,
                CustomDropdownField(
                  value: selectedViolation,
                  items:
                      violationTypes
                          .map((e) => DropdownItem(label: e, value: e))
                          .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedViolation = value;
                    });
                  },
                ),
                if (selectedViolation == 'Other') ...[
                  AppSpacing.vMd,
                  TextField(
                    controller: otherController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Specify the violation...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),

        onSubmit: () {
          final violation =
              selectedViolation == 'Other'
                  ? otherController.text.trim()
                  : selectedViolation;
          if (violation != null && violation.isNotEmpty) {
            ctx.read<ViolationCubit>().reportViolation(
              reportedBy: currentUser?.fullname ?? AppStrings.securityPersonnel,
              plateNumber: vehicle.plateNumber,
              vehicleID: vehicle.id,
              owner: vehicle.ownerName,
              violation: violation,
            );
          }
        },
        submitText: 'Submit Report',
      );
    }

    return BlocProvider(
      create: (context) => ViolationCubit(),
      child: BlocListener<ViolationCubit, ViolationState>(
        listener: (context, state) {
          if (state is ViolationSuccess) {
            BannerToast.show(
              context,
              message: 'Report submitted successfully!',
              type: BannerToastType.success,
            );
            Navigator.pop(context); // Close bottom sheet
          } else if (state is ViolationError) {
            BannerToast.show(
              context,
              message: 'Failed to submit violation!',
              type: BannerToastType.error,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            pageTitle: 'Vehicle Information',
            actions: [
              Builder(
                builder:
                    (innerCtx) => IconButton(
                      onPressed: () => showReportBottomSheet(innerCtx),
                      icon: Icon(
                        PhosphorIconsBold.warning,
                        color: AppColors.white,
                      ),
                    ),
              ),
            ],
          ),
          body: Stack(
            children: [
              CustomHeader(headerHeight: headerHeight),
              ListView(
                padding: EdgeInsets.only(
                  top: AppSpacing.md,
                  left: AppSpacing.horizontalLg.left,
                  right: AppSpacing.horizontalLg.right,
                  bottom: AppSpacing.md,
                ),
                children: [
                  CustomPlateSection(plateNumber: vehicle.plateNumber),
                  AppSpacing.vLg,
                  Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.lg),
                    child: InfoSectionFactory.createStudentInfoSection(
                      studentInfo,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.lg),
                    child: InfoSectionFactory.createAddressSection(addressInfo),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.lg),
                    child: InfoSectionFactory.createVehicleDetailsSection(
                      vehicleDetails,
                    ),
                  ),
                  Builder(
                    builder:
                        (innerCtx) => Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.lg),
                          child: CustomButton(
                            onSubmit: () => showReportBottomSheet(innerCtx),
                            btnText: 'Report',
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
