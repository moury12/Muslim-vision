// To parse this JSON data, do
//
//     final namesOfAllahModel = namesOfAllahModelFromJson(jsonString);

import 'dart:convert';

List<NamesOfAllahModel> namesOfAllahModelFromJson(String str) => List<NamesOfAllahModel>.from(json.decode(str).map((x) => NamesOfAllahModel.fromJson(x)));

String namesOfAllahModelToJson(List<NamesOfAllahModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NamesOfAllahModel {
  String arabic;
  String audioUrl;
  String meaningInBangla;
  String meaningInEnglish;
  String nameInBangla;
  String nameInEnglish;

  NamesOfAllahModel({
    required this.arabic,
    required this.audioUrl,
    required this.meaningInBangla,
    required this.meaningInEnglish,
    required this.nameInBangla,
    required this.nameInEnglish,
  });

  factory NamesOfAllahModel.fromJson(Map<String, dynamic> json) => NamesOfAllahModel(
    arabic: json["arabic"],
    audioUrl: json["audio_url"],
    meaningInBangla: json["meaning_in_bangla"],
    meaningInEnglish: json["meaning_in_english"],
    nameInBangla: json["name_in_bangla"],
    nameInEnglish: json["name_in_english"],
  );

  Map<String, dynamic> toJson() => {
    "arabic": arabic,
    "audio_url": audioUrl,
    "meaning_in_bangla": meaningInBangla,
    "meaning_in_english": meaningInEnglish,
    "name_in_bangla": nameInBangla,
    "name_in_english": nameInEnglish,
  };
}
