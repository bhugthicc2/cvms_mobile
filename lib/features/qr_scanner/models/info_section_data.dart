class InfoSectionData {
  final String label;
  final String value;

  const InfoSectionData({required this.label, required this.value});
}

class StudentInfoData {
  final String schoolId;
  final String fullname;
  final String gender;
  final String course;
  final String yearLevel;
  final String block;
  final String contact;

  const StudentInfoData({
    required this.schoolId,
    required this.fullname,
    required this.gender,
    required this.course,
    required this.yearLevel,
    required this.block,
    required this.contact,
  });

  List<InfoSectionData> toInfoSectionData() {
    return [
      InfoSectionData(label: 'School ID', value: schoolId),
      InfoSectionData(label: 'Fullname', value: fullname),
      InfoSectionData(label: 'Gender', value: gender),
      InfoSectionData(label: 'Course', value: course),
      InfoSectionData(label: 'Year Level', value: yearLevel),
      InfoSectionData(label: 'Block', value: block),
      InfoSectionData(label: 'Contact', value: contact),
    ];
  }
}

class AddressData {
  final String purok;
  final String barangay;
  final String cityMunicipality;
  final String province;

  const AddressData({
    required this.purok,
    required this.barangay,
    required this.cityMunicipality,
    required this.province,
  });

  List<InfoSectionData> toInfoSectionData() {
    return [
      InfoSectionData(label: 'Purok', value: purok),
      InfoSectionData(label: 'Barangay', value: barangay),
      InfoSectionData(label: 'City/Municipality', value: cityMunicipality),
      InfoSectionData(label: 'Province', value: province),
    ];
  }
}

class VehicleDetailsData {
  final String plateNumber;
  final String model;
  final String color;

  const VehicleDetailsData({
    required this.plateNumber,
    required this.model,
    required this.color,
  });

  List<InfoSectionData> toInfoSectionData() {
    return [
      InfoSectionData(label: 'Plate Number', value: plateNumber),
      InfoSectionData(label: 'Model', value: model),
      InfoSectionData(label: 'Color', value: color),
    ];
  }
}
