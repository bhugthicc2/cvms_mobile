import 'package:cvms_mobile/features/qr_scanner/models/info_section_data.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/cards/custom_vehicle_section.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InfoSectionFactory {
  /// Creates a student information section
  static CustomInfoSection createStudentInfoSection(StudentInfoData data) {
    return CustomInfoSection(
      categoryName: 'Student information',
      icon: PhosphorIconsBold.user,
      data: data.toInfoSectionData(),
    );
  }

  /// Creates an address information section
  static CustomInfoSection createAddressSection(AddressData data) {
    return CustomInfoSection(
      categoryName: 'Address',
      icon: PhosphorIconsBold.mapPin,
      data: data.toInfoSectionData(),
    );
  }

  /// Creates a vehicle details section
  static CustomInfoSection createVehicleDetailsSection(
    VehicleDetailsData data,
  ) {
    return CustomInfoSection(
      categoryName: 'Vehicle Details',
      icon: PhosphorIconsBold.motorcycle,
      data: data.toInfoSectionData(),
    );
  }

  /// Creates a custom info section with any data
  static CustomInfoSection createCustomSection({
    required String categoryName,
    required IconData icon,
    required List<InfoSectionData> data,
  }) {
    return CustomInfoSection(
      categoryName: categoryName,
      icon: icon,
      data: data,
    );
  }
}
