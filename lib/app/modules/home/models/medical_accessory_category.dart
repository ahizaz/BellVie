// class MedicalAccessoryCategory {
//   final int id;
//   final String name;
//   final String? image;
//   final String? createdAt;

//   MedicalAccessoryCategory({
//     required this.id,
//     required this.name,
//     this.image,
//     this.createdAt,
//   });

//   factory MedicalAccessoryCategory.fromJson(Map<String, dynamic> json) {
//     return MedicalAccessoryCategory(
//       id: (json['id'] ?? 0) as int,
//       name: (json['name'] ?? '').toString(),
//       image: json['image']?.toString(),
//       createdAt:
//           json['created_at']?.toString(),
//     );
//   }
// }
class MedicalAccessoryCategory {
  final int id;
  final String name;
  final String? image;

  // API Details
  final String? details;
  final String? detailsEn;
  final String? detailsBn;

  final String? createdAt;

  MedicalAccessoryCategory({
    required this.id,
    required this.name,
    this.image,
    this.details,
    this.detailsEn,
    this.detailsBn,
    this.createdAt,
  });

  factory MedicalAccessoryCategory.fromJson(
    Map<String, dynamic> json,
  ) {
    return MedicalAccessoryCategory(
      id: (json['id'] ?? 0) is int
          ? json['id'] as int
          : int.tryParse(
                (json['id'] ?? '0').toString(),
              ) ??
              0,

      name: (json['name'] ?? '').toString(),

      image: json['image']?.toString(),

      details: json['details']?.toString(),

      detailsEn: json['details_en']?.toString(),

      detailsBn: json['details_bn']?.toString(),

      createdAt: json['created_at']?.toString(),
    );
  }
}