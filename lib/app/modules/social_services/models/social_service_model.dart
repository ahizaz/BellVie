
class SocialServiceModel {
  final String id;
  final String titleKey;
  final String image;
  final String descriptionKey;

  SocialServiceModel({
    required this.id,
    required this.titleKey,
    required this.image,
    required this.descriptionKey,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'titleKey': titleKey,
        'image': image,
        'descriptionKey': descriptionKey,
      };

  factory SocialServiceModel.fromJson(Map<String, dynamic> json) =>
      SocialServiceModel(
        id: json['id'] ?? '',
        titleKey: json['titleKey'] ?? '',
        image: json['image'] ?? '',
        descriptionKey: json['descriptionKey'] ?? '',
      );
}
