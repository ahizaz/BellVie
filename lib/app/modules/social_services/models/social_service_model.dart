class SocialServiceModel {
  final String id;
  final String title;
  final String image;
  final String description;

  SocialServiceModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'description': description,
      };

  factory SocialServiceModel.fromJson(Map<String, dynamic> json) =>
      SocialServiceModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        image: json['image'] ?? '',
        description: json['description'] ?? '',
      );
}
