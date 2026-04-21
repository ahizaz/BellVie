class SpecialistDoctorItem {
  final String id;
  final String name;
  final String designation;
  final String imageAssetPath;

  const SpecialistDoctorItem({
    required this.id,
    required this.name,
    required this.designation,
    required this.imageAssetPath,
  });

  factory SpecialistDoctorItem.fromJson(Map<String, dynamic> json) {
    return SpecialistDoctorItem(
      id: (json['id'] ?? json['uuid'] ?? '').toString(),
      name: (json['name'] ?? json['doctor_name'] ?? '').toString(),
      designation:
          (json['designation'] ?? json['speciality'] ?? json['title'] ?? '')
              .toString(),
      imageAssetPath: (json['imageAssetPath'] ??
              json['image'] ??
              json['profile_picture'] ??
              json['avatar'] ??
              '')
          .toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'imageAssetPath': imageAssetPath,
    };
  }
}
