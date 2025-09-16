import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/utils/bottom_sheet_utils.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/cards/custom_plate_section.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/cards/info_section_factory.dart';
import 'package:cvms_mobile/features/qr_scanner/models/info_section_data.dart';
import 'package:cvms_mobile/features/qr_scanner/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/widgets/custom_app_bar.dart';

class VehicleInfoPage extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleInfoPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.28;

    // todo Replace with actual data from your backend/state management
    // mock data to be used if not exist
    final studentInfo = StudentInfoData(
      schoolId: vehicle.schoolID, //actual
      fullname: vehicle.ownerName, // actual
      gender: 'N/A',
      course: vehicle.department,
      yearLevel: 'N/A',
      block: 'N/A',
      contact: 'N/A',
    );

    final addressInfo = AddressData(
      purok: 'N/A',
      barangay: 'N/A',
      cityMunicipality: 'N/A',
      province: 'N/A',
    );

    final vehicleDetails = VehicleDetailsData(
      plateNumber: vehicle.plateNumber, // actual
      model: vehicle.vehicleModel, // actual
      color: vehicle.vehicleColor, //actual
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        pageTitle: 'Vehicle Information',
        actions: [
          IconButton(
            onPressed: () {
              showCustomBottomSheet(
                context: context,
                title: "Report Issue",
                child: Column(
                  //todo add a violations dropdown
                  //todo add a field for specifying other violation
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Describe your issue"),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Type your report here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                onSubmit: () {
                  // todo report logic
                  debugPrint("Report submitted!");
                  Navigator.pop(context); // close bottom sheet
                },
                submitText: "Submit Report",
              );
            },
            icon: Icon(PhosphorIconsBold.warning, color: AppColors.white),
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
                child: InfoSectionFactory.createStudentInfoSection(studentInfo),
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
              Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.lg),
                child: CustomButton(
                  onSubmit: () {
                    showCustomBottomSheet(
                      context: context,
                      title: "Report Issue",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Describe your issue"),
                          const SizedBox(height: 10),
                          TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Type your report here...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onSubmit: () {
                        // 🔹 Do your "Report" logic here
                        debugPrint("Report submitted!");
                        Navigator.pop(context); // close bottom sheet
                      },
                      submitText: "Submit Report",
                    );
                  },
                  btnText: 'Report',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
