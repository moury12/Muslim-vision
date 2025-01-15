
import 'dart:convert';

List<QurbaniModel> qurbaniModelFromJson(String str) =>
    List<QurbaniModel>.from(json.decode(str).map((x) => QurbaniModel.fromJson(x)));

String qurbaniModelToJson(List<QurbaniModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QurbaniModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<Data> data;

  QurbaniModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.data,
  });

  factory QurbaniModel.fromJson(Map<String, dynamic> json) => QurbaniModel(
    categoryInBangla: json["category-in-bangla"],
    categoryInEnglish: json["category-in-english"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category-in-bangla": categoryInBangla,
    "category-in-english": categoryInEnglish,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  String detailsInBangla;
  String detailsInEnglish;
  String imageUrl;
  String refInBangla;
  String refInEnglish;
  String source;

  Data({
    required this.detailsInBangla,
    required this.detailsInEnglish,
    required this.imageUrl,
    required this.refInBangla,
    required this.refInEnglish,
    required this.source,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
