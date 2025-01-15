// To parse this JSON data, do
//
//     final wuduProcedureModel = wuduProcedureModelFromJson(jsonString);

import 'dart:convert';

List<WuduProcedureModel> wuduProcedureModelFromJson(String str) =>
    List<WuduProcedureModel>.from(json.decode(str).map((x) => WuduProcedureModel.fromJson(x)));

String wuduProcedureModelToJson(List<WuduProcedureModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WuduProcedureModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<Datum> data;

  WuduProcedureModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.data,
  });

  factory WuduProcedureModel.fromJson(Map<String, dynamic> json) => WuduProcedureModel(
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
