// To parse this JSON data, do
//
//     final greetingsModel = greetingsModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<GreetingsModel> greetingsModelFromJson(String str) => List<GreetingsModel>.from(json.decode(str).map((x) => GreetingsModel.fromJson(x)));

String greetingsModelToJson(List<GreetingsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GreetingsModel {
    String greetingsInBangla;
    String greetingsInEnglish;
    List<GreetingDataModel> data;

    GreetingsModel({
        required this.greetingsInBangla,
        required this.greetingsInEnglish,
        required this.data,
    });

    factory GreetingsModel.fromJson(Map<String, dynamic> json) => GreetingsModel(
        greetingsInBangla: json["greetings-in-bangla"],
        greetingsInEnglish: json["greetings-in-english"],
        data: List<GreetingDataModel>.from(json["data"].map((x) => GreetingDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "greetings-in-bangla": greetingsInBangla,
        "greetings-in-english": greetingsInEnglish,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GreetingDataModel {
    String source;
    String imageUrl;
    ImageCredit imageCredit;
    String refInBangla;
    String refInEnglish;
    String meaningInBangla;
    String detailsInEnglish;

    GreetingDataModel({
        required this.source,
        required this.imageUrl,
        required this.imageCredit,
        required this.refInBangla,
        required this.refInEnglish,
        required this.meaningInBangla,
        required this.detailsInEnglish,
    });

    factory GreetingDataModel.fromJson(Map<String, dynamic> json) => GreetingDataModel(
        source: json["source"],
        imageUrl: json["image-url"],
        imageCredit: imageCreditValues.map[json["image-credit"]]!,
        refInBangla: json["ref-in-bangla"],
        refInEnglish: json["ref-in-english"],
        meaningInBangla: json["meaning-in-bangla"],
        detailsInEnglish: json["details-in-english"],
    );

    Map<String, dynamic> toJson() => {
        "source": source,
        "image-url": imageUrl,
        "image-credit": imageCreditValues.reverse[imageCredit],
        "ref-in-bangla": refInBangla,
        "ref-in-english": refInEnglish,
        "meaning-in-bangla": meaningInBangla,
        "details-in-english": detailsInEnglish,
    };
}

enum ImageCredit {
    EMPTY,
    MUSLIM_PRO
}

final imageCreditValues = EnumValues({
    "": ImageCredit.EMPTY,
    "muslim-pro": ImageCredit.MUSLIM_PRO
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
