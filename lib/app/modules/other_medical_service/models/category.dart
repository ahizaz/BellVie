class OtherMedicalCategory {
  final int id;
  final String name;
  final String? image;
  final String? createdAt;

  OtherMedicalCategory({
    required this.id,
    required this.name,
    this.image,
    this.createdAt,
  });

  factory OtherMedicalCategory.fromJson(Map<String, dynamic> json) {
    return OtherMedicalCategory(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '').toString(),
      image: json['image'] == null ? null : json['image'].toString(),
      createdAt:
          json['created_at'] == null ? null : json['created_at'].toString(),
    );
  }
}
