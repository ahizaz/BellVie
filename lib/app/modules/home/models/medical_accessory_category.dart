class MedicalAccessoryCategory {
  final int id;
  final String name;
  final String? image;
  final String? createdAt;

  MedicalAccessoryCategory({
    required this.id,
    required this.name,
    this.image,
    this.createdAt,
  });

  factory MedicalAccessoryCategory.fromJson(Map<String, dynamic> json) {
    return MedicalAccessoryCategory(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '').toString(),
      image: json['image']?.toString(),
      createdAt:
          json['created_at']?.toString(),
    );
  }
}
