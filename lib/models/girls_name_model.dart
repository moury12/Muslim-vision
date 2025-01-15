
import 'package:flutter/foundation.dart';

class GirlsName {
  String? categoryInBangla;
  String? categoryInEnglish;
  List<NameList>? nameList;

  GirlsName({this.categoryInBangla, this.categoryInEnglish, this.nameList});

  GirlsName.fromJson(Map<String, dynamic> json) {
    categoryInBangla = json['category-in-bangla'];
    categoryInEnglish = json['category-in-english'];
    if (json['name_list'] != null) {
      nameList = <NameList>[];
      json['name_list'].forEach((v) {
        nameList!.add(NameList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category-in-bangla'] = categoryInBangla;
    data['category-in-english'] = categoryInEnglish;
    if (nameList != null) {
      data['name_list'] = nameList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(covariant GirlsName other) {
    if (identical(this, other)) return true;

    return
      other.categoryInBangla == categoryInBangla &&
          other.categoryInEnglish == categoryInEnglish &&
          listEquals(other.nameList, nameList);
  }

  @override
  int get hashCode => categoryInBangla.hashCode ^ categoryInEnglish.hashCode ^ nameList.hashCode;
}

class NameList {
  String? meaningInBangla;
  String? meaningInEnglsih;
  String? nameInArabic;
  String? nameInBangla;
  String? nameInEnglish;
  String? noteInBangla;
  String? noteInEnglish;

  NameList(
      {this.meaningInBangla,
        this.meaningInEnglsih,
        this.nameInArabic,
        this.nameInBangla,
        this.nameInEnglish,
        this.noteInBangla,
        this.noteInEnglish});

  NameList.fromJson(Map<String, dynamic> json) {
    meaningInBangla = json['meaning-in-bangla'];
    meaningInEnglsih = json['meaning-in-englsih'];
    nameInArabic = json['name-in-arabic'];
    nameInBangla = json['name-in-bangla'];
    nameInEnglish = json['name-in-english'];
    noteInBangla = json['note-in-bangla'];
    noteInEnglish = json['note-in-english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meaning-in-bangla'] = meaningInBangla;
    data['meaning-in-englsih'] = meaningInEnglsih;
    data['name-in-arabic'] = nameInArabic;
    data['name-in-bangla'] = nameInBangla;
    data['name-in-english'] = nameInEnglish;
    data['note-in-bangla'] = noteInBangla;
    data['note-in-english'] = noteInEnglish;
    return data;
  }

  @override
  bool operator ==(covariant NameList other) {
    if (identical(this, other)) return true;

    return
      other.meaningInBangla == meaningInBangla &&
          other.meaningInEnglsih == meaningInEnglsih &&
          other.nameInArabic == nameInArabic &&
          other.nameInBangla == nameInBangla &&
          other.nameInEnglish == nameInEnglish &&
          other.noteInBangla == noteInBangla &&
          other.noteInEnglish == noteInEnglish;
  }

  @override
  int get hashCode {
    return meaningInBangla.hashCode ^
    meaningInEnglsih.hashCode ^
    nameInArabic.hashCode ^
    nameInBangla.hashCode ^
    nameInEnglish.hashCode ^
    noteInBangla.hashCode ^
    noteInEnglish.hashCode;
  }
}
