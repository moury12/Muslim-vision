
import 'dart:convert';

List<FivePillarsOfIslamModel> fivePillarsOfIslamModelFromJson(String str) =>
    List<FivePillarsOfIslamModel>.from(json.decode(str).map((x) => FivePillarsOfIslamModel.fromJson(x)));
//utf8.decode(str.codeUnits)

String fivePillarsOfIslamModelToJson(List<FivePillarsOfIslamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FivePillarsOfIslamModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<Data> data;

  FivePillarsOfIslamModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.data,
  });

  factory FivePillarsOfIslamModel.fromJson(Map<String, dynamic> json) => FivePillarsOfIslamModel(
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
  String source;

  Data({
    required this.detailsInBangla,
    required this.detailsInEnglish,
    required this.imageUrl,
    required this.source,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    detailsInBangla: json["details-in-bangla"],
    detailsInEnglish: json["details-in-english"],
    imageUrl: json["image-url"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "details-in-bangla": detailsInBangla,
    "details-in-english": detailsInEnglish,
    "image-url": imageUrl,
    "source": source,
  };
}
