// To parse this JSON data, do
//
//     final doaModel = doaModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<DoaModel> doaModelFromJson(String str) =>
    List<DoaModel>.from(json.decode(str).map((x) => DoaModel.fromJson(x)));

String doaModelToJson(List<DoaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoaModel {
  String categoryInBangla;
  String categoryInEnglish;
  List<SubCategory> subCategories;

  DoaModel({
    required this.categoryInBangla,
    required this.categoryInEnglish,
    required this.subCategories,
  });

  factory DoaModel.fromJson(Map<String, dynamic> json) => DoaModel(
        categoryInBangla: json["category-in-bangla"],
        categoryInEnglish: json["category-in-english"],
        subCategories: List<SubCategory>.from(json["sub-categories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category-in-bangla": categoryInBangla,
        "category-in-english": categoryInEnglish,
        "sub-categories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };
}

class SubCategory {
  List<Datum> data;
  String subCategoryInBangla;
  SubCategoryInEnglish subCategoryInEnglish;

  SubCategory({
    required this.data,
    required this.subCategoryInBangla,
    required this.subCategoryInEnglish,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))).toList(),
        subCategoryInBangla: json["sub-category-in-bangla"],
        subCategoryInEnglish:
            subCategoryInEnglishValues.map[json["sub-category-in-english"]]!,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "sub-category-in-bangla": subCategoryInBangla,
        "sub-category-in-english":
            subCategoryInEnglishValues.reverse[subCategoryInEnglish],
      };
}

class Datum {
  String audioUrl;
  String detailsInBangla;
  String detailsInEnglish;
  String imageUrl;
  String refInBangla;
  String refInEnglish;
  String source;

  Datum({
    required this.audioUrl,
    required this.detailsInBangla,
    required this.detailsInEnglish,
    required this.imageUrl,
    required this.refInBangla,
    required this.refInEnglish,
    required this.source,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        audioUrl: json["audio-url"],
        detailsInBangla: json["details-in-bangla"],
        detailsInEnglish: json["details-in-english"],
        imageUrl: json["image-url"],
        refInBangla: json["ref-in-bangla"],
        refInEnglish: json["ref-in-english"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "audio-url": audioUrl,
        "details-in-bangla": detailsInBangla,
        "details-in-english": detailsInEnglish,
        "image-url": imageUrl,
        "ref-in-bangla": refInBangla,
        "ref-in-english": refInEnglish,
        "source": source,
      };
}

enum SubCategoryInEnglish { EMPTY, THE_82_WHEN_ANGRY }

final subCategoryInEnglishValues = EnumValues({
  "": SubCategoryInEnglish.EMPTY,
  "82 - When angry": SubCategoryInEnglish.THE_82_WHEN_ANGRY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
