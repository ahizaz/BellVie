import 'dart:convert';

class SliderTwo {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  SliderTwo({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SliderTwo.fromRawJson(String str) => SliderTwo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SliderTwo.fromJson(Map<String, dynamic> json) => SliderTwo(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? image;
  DateTime? createdAt;

  Result({
    this.id,
    this.image,
    this.createdAt,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
  };
}
