import 'dart:convert';

class SpecialDoctor {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  SpecialDoctor({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SpecialDoctor.fromRawJson(String str) => SpecialDoctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpecialDoctor.fromJson(Map<String, dynamic> json) => SpecialDoctor(
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
  String? name;
  String? image;
  String? designation;
  int? yearsOfExperience;
  String? doctorFees;
  String? hospitalName;

  Result({
    this.id,
    this.name,
    this.image,
    this.designation,
    this.yearsOfExperience,
    this.doctorFees,
    this.hospitalName,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    designation: json["designation"],
    yearsOfExperience: json["years_of_experience"],
    doctorFees: json["doctor_fees"],
    hospitalName: json["hospital_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "designation": designation,
    "years_of_experience": yearsOfExperience,
    "doctor_fees": doctorFees,
    "hospital_name": hospitalName,
  };
}

