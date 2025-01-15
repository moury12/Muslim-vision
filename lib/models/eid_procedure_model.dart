import 'dart:convert';

List<EidProcedureModel> eidProcedureModelFromJson(String str) =>
    List<EidProcedureModel>.from(json.decode(str).map((x) => EidProcedureModel.fromJson(x)));

String eidProcedureModelToJson(List<EidProcedureModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EidProcedureModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<Datum> data;

  EidProcedureModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.data,
  });

  factory EidProcedureModel.fromJson(Map<String, dynamic> json) => EidProcedureModel(
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
  String source;
  String imageUrl;
  String refInBangla;
  String refInEnglish;
  String detailsInBangla;
  String detailsInEnglish;

  Datum({
    required this.source,
    required this.imageUrl,
    required this.refInBangla,
    required this.refInEnglish,
    required this.detailsInBangla,
    required this.detailsInEnglish,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        source: json["source"],
        imageUrl: json["image-url"],
        refInBangla: json["ref-in-bangla"],
        refInEnglish: json["ref-in-english"],
        detailsInBangla: json["details-in-bangla"],
        detailsInEnglish: json["details-in-english"],
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "image-url": imageUrl,
        "ref-in-bangla": refInBangla,
        "ref-in-english": refInEnglish,
        "details-in-bangla": detailsInBangla,
        "details-in-english": detailsInEnglish,
      };
}
