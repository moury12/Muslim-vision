
import 'package:muslim_vision/models/girls_name_model.dart';

class BoysName {
  String? categoryInBangla;
  String? categoryInEnglish;
  List<NameList>? nameList;

  BoysName({this.categoryInBangla, this.categoryInEnglish, this.nameList});

  BoysName.fromJson(Map<String, dynamic> json) {
    categoryInBangla = json['category-in-bangla'];
    categoryInEnglish = json['category-in-english'];
    if (json['name_list'] != null) {
      nameList = <NameList>[];
      json['name_list'].forEach((v) {
        nameList!.add( NameList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['category-in-bangla'] = categoryInBangla;
    data['category-in-english'] = categoryInEnglish;
    if (nameList != null) {
      data['name_list'] = nameList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
