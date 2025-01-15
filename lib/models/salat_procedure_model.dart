// To parse this JSON data, do
//
//     final salatProcedureModel = salatProcedureModelFromJson(jsonString);

import 'dart:convert';

SalatProcedureModel salatProcedureModelFromJson(String str) => SalatProcedureModel.fromJson(json.decode(str));

String salatProcedureModelToJson(SalatProcedureModel data) => json.encode(data.toJson());

class SalatProcedureModel {
  List<Salam> common;
  List<Salam> initial;
  Salam salam;
  Salam sitting2;
  Salam standing;
  Salam sitting1;
  Salam witr;

  SalatProcedureModel({
    required this.common,
    required this.initial,
    required this.salam,
    required this.sitting2,
    required this.standing,
    required this.sitting1,
    required this.witr,
  });

  factory SalatProcedureModel.fromJson(Map<String, dynamic> json) => SalatProcedureModel(
    common: List<Salam>.from(json["common"].map((x) => Salam.fromJson(x))),
    initial: List<Salam>.from(json["initial"].map((x) => Salam.fromJson(x))),
    salam: Salam.fromJson(json["salam"]),
    sitting2: Salam.fromJson(json["sitting2"]),
    standing: Salam.fromJson(json["standing"]),
    sitting1: Salam.fromJson(json["stitting1"]),
    witr: Salam.fromJson(json["witr"]),
  );

  Map<String, dynamic> toJson() => {
    "common": List<dynamic>.from(common.map((x) => x.toJson())),
    "initial": List<dynamic>.from(initial.map((x) => x.toJson())),
    "salam": salam.toJson(),
    "sitting2": sitting2.toJson(),
    "standing": standing.toJson(),
    "stitting1": sitting1.toJson(),
    "witr": witr.toJson(),
  };
}

class Salam {
  String categoryInBangla;
  String categoryInEnglish;
  String detailsInBangla;
  String detailsInEnglish;
  String imageUrl;
  String refInBangla;
  String refInEnglish;

  Salam({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.detailsInBangla,
    required this.detailsInEnglish,
    required this.imageUrl,
    required this.refInBangla,
    required this.refInEnglish,
  });

  factory Salam.fromJson(Map<String, dynamic> json) => Salam(
    categoryInBangla: json["category-in-bangla"],
    categoryInEnglish: json["category-in-english"],
    detailsInBangla: json["details-in-bangla"],
    detailsInEnglish: json["details-in-english"],
    imageUrl: json["imageUrl"],
    refInBangla: json["ref-in-bangla"],
    refInEnglish: json["ref-in-english"],
  );

  Map<String, dynamic> toJson() => {
    "category-in-bangla": categoryInBangla,
    "category-in-english": categoryInEnglish,
    "details-in-bangla": detailsInBangla,
    "details-in-english": detailsInEnglish,
    "imageUrl": imageUrl,
    "ref-in-bangla": refInBangla,
    "ref-in-english": refInEnglish,
  };
}
