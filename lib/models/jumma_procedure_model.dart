// To parse this JSON data, do
//
//     final jummaProcedureModel = jummaProcedureModelFromJson(jsonString);

import 'dart:convert';

List<JummaProcedureModel> jummaProcedureModelFromJson(String str) =>
    List<JummaProcedureModel>.from(json.decode(str).map((x) => JummaProcedureModel.fromJson(x)));

String jummaProcedureModelToJson(List<JummaProcedureModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JummaProcedureModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<Datum> data;

  JummaProcedureModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.data,
  });

  factory JummaProcedureModel.fromJson(Map<String, dynamic> json) => JummaProcedureModel(
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
  String source;

  Datum({
    required this.detailsInBangla,
    required this.detailsInEnglish,
    required this.imageUrl,
    required this.refInBangla,
    required this.refInEnglish,
    required this.source,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        detailsInBangla: json["details-in-bangla"],
        detailsInEnglish: json["details-in-english"],
        imageUrl: json["image-url"],
        refInBangla: json["ref-in-bangla"],
        refInEnglish: json["ref-in-english"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "details-in-bangla": detailsInBangla,
        "details-in-english": detailsInEnglish,
        "image-url": imageUrl,
        "ref-in-bangla": refInBangla,
        "ref-in-english": refInEnglish,
        "source": source,
      };
}
