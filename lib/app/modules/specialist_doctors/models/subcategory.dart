class Subcategory {
  final int id;
  final int? category;
  final String name;
  final String? icon;

  Subcategory({
    required this.id,
    this.category,
    required this.name,
    this.icon,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: (json['id'] ?? 0) as int,
      category: json['category'] is int ? json['category'] as int : null,
      name: (json['name'] ?? '').toString(),
      icon: json['icon']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'icon': icon,
    };
  }
}
