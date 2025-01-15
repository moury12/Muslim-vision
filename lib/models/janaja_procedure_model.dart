// To parse this JSON data, do
//
//     final janajaProcedureModel = janajaProcedureModelFromJson(jsonString);

import 'dart:convert';

List<JanajaProcedureModel> janajaProcedureModelFromJson(String str) =>
    List<JanajaProcedureModel>.from(json.decode(str).map((x) => JanajaProcedureModel.fromJson(x)));

String janajaProcedureModelToJson(List<JanajaProcedureModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JanajaProcedureModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<Datum> data;

  JanajaProcedureModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.data,
  });

  factory JanajaProcedureModel.fromJson(Map<String, dynamic> json) => JanajaProcedureModel(
        categoryInBangla: json["category-in-bangla"],
        categoryInEnglish: json["category-in-english"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category-in-bangla": categoryInBangla,
        "category-in-english": categoryInEnglish,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String detailsInBangla;
  String detailsInEnglish;
  String imageUrl;
  String refInBangla;
  String refInEnglish;

  Datum({
    required this.detailsInBangla,
    required this.detailsInEnglish,
    required this.imageUrl,
    required this.refInBangla,
    required this.refInEnglish,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        detailsInBangla: json["details-in-bangla"],
        detailsInEnglish: json["details-in-english"],
        imageUrl: json["image-url"],
        refInBangla: json["ref-in-bangla"],
        refInEnglish: json["ref-in-english"],
      );

  Map<String, dynamic> toJson() => {
        "details-in-bangla": detailsInBangla,
        "details-in-english": detailsInEnglish,
        "image-url": imageUrl,
        "ref-in-bangla": refInBangla,
        "ref-in-english": refInEnglish,
      };
}
