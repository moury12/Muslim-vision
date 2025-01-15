// To parse this JSON data, do
//
//     final nameModel = nameModelFromJson(jsonString);

import 'dart:convert';

List<NameModel> nameModelFromJson(String str) => List<NameModel>.from(json.decode(str).map((x) => NameModel.fromJson(x)));

String nameModelToJson(List<NameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NameModel {
  final String? categoryInBangla;
  final String? categoryInEnglish;
  final List<NameList>? nameList;

  NameModel({
    this.categoryInBangla,
    this.categoryInEnglish,
    this.nameList,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        categoryInBangla: json["category-in-bangla"],
        categoryInEnglish: json["category-in-english"],
        nameList: json["name_list"] == null ? [] : List<NameList>.from(json["name_list"]!.map((x) => NameList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category-in-bangla": categoryInBangla,
        "category-in-english": categoryInEnglish,
        "name_list": nameList == null ? [] : List<dynamic>.from(nameList!.map((x) => x.toJson())),
      };
}

class NameList {
  final String? meaningInBangla;
  final String? meaningInEnglsih;
  final String? nameInArabic;
  final String? nameInBangla;
  final String? nameInEnglish;
  final String? noteInBangla;
  final String? noteInEnglish;

  NameList({
    this.meaningInBangla,
    this.meaningInEnglsih,
    this.nameInArabic,
    this.nameInBangla,
    this.nameInEnglish,
    this.noteInBangla,
    this.noteInEnglish,
  });

  factory NameList.fromJson(Map<String, dynamic> json) => NameList(
        meaningInBangla: json["meaning-in-bangla"],
        meaningInEnglsih: json["meaning-in-englsih"],
        nameInArabic: json["name-in-arabic"],
        nameInBangla: json["name-in-bangla"],
        nameInEnglish: json["name-in-english"],
        noteInBangla: json["note-in-bangla"],
        noteInEnglish: json["note-in-english"],
      );

  Map<String, dynamic> toJson() => {
        "meaning-in-bangla": meaningInBangla,
        "meaning-in-englsih": meaningInEnglsih,
        "name-in-arabic": nameInArabic,
        "name-in-bangla": nameInBangla,
        "name-in-english": nameInEnglish,
        "note-in-bangla": noteInBangla,
        "note-in-english": noteInEnglish,
      };
}
