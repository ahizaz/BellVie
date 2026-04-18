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
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      designation: json['designation']?.toString() ?? '',
      imageAssetPath: json['imageAssetPath']?.toString() ?? '',
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
