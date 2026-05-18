import 'dart:convert';

class DiscountPartner {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  DiscountPartner({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DiscountPartner.fromRawJson(String str) =>
      DiscountPartner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscountPartner.fromJson(Map<String, dynamic> json) =>
      DiscountPartner(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? name;
  String? nameEn;
  String? nameBn;
  String? icon;
  DateTime? createdAt;

  Result({
    this.id,
    this.name,
    this.nameEn,
    this.nameBn,
    this.icon,
    this.createdAt,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        nameBn: json["name_bn"],
        icon: json["icon"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_en": nameEn,
        "name_bn": nameBn,
        "icon": icon,
        "created_at": createdAt?.toIso8601String(),
      };
}
