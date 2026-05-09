class SpecialistDoctorItem {
  final String id;
  final String name;
  final String designation;
  final String imageAssetPath;
  final String hospitalName;
  final String subcategoryName;
  final String experience;
  final String fees;

  const SpecialistDoctorItem({
    required this.id,
    required this.name,
    required this.designation,
    required this.imageAssetPath,
    this.hospitalName = '',
    this.subcategoryName = '',
    this.experience = '',
    this.fees = '',
  });

  factory SpecialistDoctorItem.fromJson(Map<String, dynamic> json) {
    final experienceValue = json['experience'] ?? json['years_of_experience'];
    final feesValue = json['fees'] ?? json['doctor_fees'];
    return SpecialistDoctorItem(
      id: (json['id'] ?? json['uuid'] ?? '').toString(),
      name: (json['name'] ?? json['doctor_name'] ?? '').toString(),
      designation: (json['designation'] ??
              json['designations'] ??
              json['speciality'] ??
              json['title'] ??
              '')
          .toString(),
      imageAssetPath: (json['imageAssetPath'] ??
              json['image'] ??
              json['profile_picture'] ??
              json['avatar'] ??
              json['profile_image'] ??
              json['photo'] ??
              '')
          .toString(),
      hospitalName:
          (json['hospital_name'] ?? json['hospital'] ?? '').toString(),
      subcategoryName: (json['subcategory_name'] ??
              json['subcategory'] ??
              json['category'] ??
              '')
          .toString(),
      experience: (experienceValue ?? '').toString(),
      fees: (feesValue ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'imageAssetPath': imageAssetPath,
      'hospital_name': hospitalName,
      'subcategory_name': subcategoryName,
      'experience': experience,
      'fees': fees,
    };
  }
}
