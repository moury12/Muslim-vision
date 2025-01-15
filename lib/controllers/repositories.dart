import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:muslim_vision/controllers/apis.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_vision/controllers/services/static_data.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/models/doa_model.dart';
import 'package:muslim_vision/models/eid_procedure_model.dart';
import 'package:muslim_vision/models/five_pillars_of_islam_model.dart';

import 'package:muslim_vision/models/greetings_model.dart';
import 'package:muslim_vision/models/janaja_procedure_model.dart';
import 'package:muslim_vision/models/jumma_procedure_model.dart';
import 'package:muslim_vision/models/name_model.dart';
import 'package:muslim_vision/models/qurbani_model.dart';
import 'package:muslim_vision/models/salat_procedure_model.dart';
import 'package:muslim_vision/models/wudu_procedure_model.dart';

import '../models/api_status_model.dart';

class Repositories {
  final dmPath = Boxes().dmPath;
  /*----------------------------------------------- DM Path ----------------------------------------*/
  Future<Map<String, dynamic>> getDMPathData() async {
    Map<String, dynamic> dmPathData = {};
    String dmPathBaseUrl = "";
    try {
      final http.Response response = await http.get(
        Uri.parse(Apis.dmPathApi),
      );

      if (response.statusCode == 200) {
        dmPathData = json.decode(response.body);
        dmPathBaseUrl = dmPathData['base-url'];
        // dmPathBaseUrl = "http://20.198.227.47:9901/muslim-vision";
        await dmPath.put('base_url', dmPathBaseUrl);
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.dmPathApi}');
      throw Exception(e);
    }
    return dmPathData;
  }

  /*----------------------------------------------- Sync Api ----------------------------------------*/
  Future<Map<dynamic, dynamic>?> syncApiFatch(String deviceId) async {
    try {
      await getDMPathData();
      final baseUrl = dmPath.get('base_url');
      debugPrint(baseUrl);
      debugPrint(deviceId);
      final http.Response response = await http.post(Uri.parse(Apis.syncApi(baseUrl)), body: jsonEncode(({"device_id": deviceId})));
      if (response.statusCode == 200) {
        debugPrint('xxxxxxxxxxxxxxxxxxx     ---hit sync api---       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        debugPrint('Response: $jsonResponse');

        return jsonResponse;
      } else {
        // Log non-200 responses
        debugPrint('Failed response: ${response.body}');
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.syncApi("baseUrl")}');
      throw Exception(e);
    }

    return {};
  }

  /*----------------------------------------------- Salat Procedure ----------------------------------------*/
  Future<SalatProcedureModel?> salatProcedureData() async {
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.salatProcedureApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        return salatProcedureModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.salatProcedureApi("baseUrl")}');
      throw Exception(e);
    }
    return null;
  }

  /*----------------------------------------------- Names Of Allah ----------------------------------------*/
  Future<List> getNamesOfAllahData() async {
    List namesOfAllahData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.nameOfAllahApi(baseUrl)),
      );
      if (response.statusCode == 200) {
        namesOfAllahData = jsonDecode(response.body);
        final namesOfAllahBox = Boxes().namesOfAllahBox;
        await namesOfAllahBox.put('namesOfAllahBox', namesOfAllahData);
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.nameOfAllahApi("baseUrl")}');
      throw Exception(e);
    }
    return namesOfAllahData;
  }

  /*----------------------------------------------- Ozu Procedure ----------------------------------------*/
  Future<List<WuduProcedureModel>> getOzuProcedureData() async {
    List<WuduProcedureModel> wuduProcedureData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.wuduProcedureApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        wuduProcedureData = wuduProcedureModelFromJson(response.body);
        return wuduProcedureData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.wuduProcedureApi("baseUrl")}');
      throw Exception(e);
    }
    return wuduProcedureData;
  }

  /*----------------------------------------------- Janaja Procedure ----------------------------------------*/
  Future<List<JanajaProcedureModel>> getJanajaProcedureData() async {
    List<JanajaProcedureModel> janajaProcedureData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.janajaProcedureApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        janajaProcedureData = janajaProcedureModelFromJson(response.body);
        return janajaProcedureData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.janajaProcedureApi("baseUrl")}');
      throw Exception(e);
    }
    return janajaProcedureData;
  }

  /*----------------------------------------------- Jumma Procedure ----------------------------------------*/
  Future<List<JummaProcedureModel>> getJummaProcedureData() async {
    List<JummaProcedureModel> jummaProcedureData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.jummaProcedureApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        jummaProcedureData = jummaProcedureModelFromJson(response.body);
        return jummaProcedureData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.jummaProcedureApi("baseUrl")}');
      throw Exception(e);
    }
    return jummaProcedureData;
  }

  /*----------------------------------------------- Eid Procedure ----------------------------------------*/
  Future<List<EidProcedureModel>> getEidProcedureData() async {
    List<EidProcedureModel> eidProcedureData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.eidProcedureApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        eidProcedureData = eidProcedureModelFromJson(response.body);
        return eidProcedureData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.eidProcedureApi("baseUrl")}');
      throw Exception(e);
    }
    return eidProcedureData;
  }

  /*----------------------------------------------- Greetings Background Section ----------------------------------------*/
  Future<List> getGreetingsBackgroundData() async {
    List greetingBgData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.greetingBackgroundApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        greetingBgData = data['greetings-bg-images'];

        return greetingBgData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.greetingBackgroundApi("baseUrl")}');
      throw Exception(e);
    }
    return greetingBgData;
  }

  /*----------------------------------------------- Greetings Section ----------------------------------------*/
  Future<List<GreetingsModel>> getGreetingsData() async {
    List<GreetingsModel> greetingsData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.greetingsApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        greetingsData = greetingsModelFromJson(response.body);
        debugPrint("Int Api ************************************");
        return greetingsData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.greetingsApi("baseUrl")}');
      throw Exception(e);
    }
    return greetingsData;
  }

  //******************************** Doa ********************************* */

  Future<List<DoaModel>> getDoa() async {
    List<DoaModel> doaData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.doaApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        doaData = doaModelFromJson(response.body);
        log(jsonEncode(doaData));

        return doaData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.doaApi('baseUrl')}');
      throw Exception(e);
    }
    return doaData;
  }

  /*----------------------------------------------- Five Pillars Of Islam ----------------------------------------*/
  Future<List<FivePillarsOfIslamModel>> getFivePillarsOfIslamData() async {
    List<FivePillarsOfIslamModel> fivePillarsOfIslamData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final http.Response response = await http.get(
        Uri.parse(Apis.shahadahApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        fivePillarsOfIslamData = fivePillarsOfIslamModelFromJson(response.body);
        return fivePillarsOfIslamData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.shahadahApi('baseUrl')}');
      throw Exception(e);
    }
    return fivePillarsOfIslamData;
  }

/*----------------------------------------------- Boys Name ----------------------------------------*/
  Future<List<NameModel>> getBoysName() async {
    List<NameModel> nameList = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final data = await get(Uri.parse(Apis.boysNameApi(baseUrl)));
      if (data.statusCode == 200) {
        nameList = nameModelFromJson(data.body);
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.boysNameApi('baseUrl')}');
      throw Exception(e);
    }
    return nameList;
  }

/*----------------------------------------------- Girls Name ----------------------------------------*/
  Future<List<NameModel>> getGirlsName() async {
    List<NameModel> nameList = [];
    try {
      final baseUrl = dmPath.get('base_url');
      final data = await get(Uri.parse(Apis.girlsNameApi(baseUrl)));
      if (data.statusCode == 200) {
        nameList = nameModelFromJson(data.body);
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.girlsNameApi("baseUrl")}');
      throw Exception(e);
    }
    return nameList;
  }

  /*----------------------------------------------- Qurbani ----------------------------------------*/
  Future<List<QurbaniModel>> getQurbaniData() async {
    List<QurbaniModel> qurbaniData = [];
    try {
      final baseUrl = dmPath.get('base_url');
      // print("base_url:$base_url");
      final http.Response response = await http.get(
        Uri.parse(Apis.qurbaniApi(baseUrl)),
      );

      if (response.statusCode == 200) {
        qurbaniData = qurbaniModelFromJson(response.body);
        return qurbaniData;
      }
    } catch (e) {
      debugPrint('${e.toString()} in ${Apis.qurbaniApi("baseUrl")}');
      throw Exception(e);
    }
    return qurbaniData;
  }

  static Future<ApiStatusModel> processAllApiAndGetStatus() async {
    final Box<dynamic> procedureBox = Boxes().procedureBox;
    final Box dhikrBox = Boxes().tasbeehBox;
    final Box namesOfAllahBox = Boxes().namesOfAllahBox;
    final Box doaBox = Boxes().doaBox;
    final Box greetingBox = Boxes().greetingsBox;
    final Box fivePilarOfIslam = Boxes().fivePillarsDataBox;
    final Box namesDataBox = Boxes().namesDataBox;
    final Box qurbaniDataBox = Boxes().qurbaniDataBox;
    /*-----------------------------------------------------------------*/
    /*-------------------------Dhikr Works Start----------------------*/
    if (dhikrBox.isEmpty) {
      await dhikrBox.put(StaticData().thirdDhikr['name'], StaticData().thirdDhikr);
      await dhikrBox.put(StaticData().secondDhikr['name'], StaticData().secondDhikr);
      await dhikrBox.put(StaticData().firstDhikr['name'], StaticData().firstDhikr);
      await dhikrBox.put('TasbeehInitialData', {
        'counter': 0,
        'loop': 1,
        'singleDhikrData': StaticData().firstDhikr,
      });
    }

    if (await dhikrBox.get('TasbeehInitialData') == null) {
      await dhikrBox.put('TasbeehInitialData', {
        'counter': 0,
        'loop': 1,
        'singleDhikrData': StaticData().firstDhikr,
      });
    }

    /*-------------------------Names Of Allah Start----------------------*/
    if (namesOfAllahBox.isEmpty) {
      try {
        await Repositories().getNamesOfAllahData();
      } catch (e) {
        log("  getNamesOfAllahData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    /*-------------------------Salat Procedure----------------------*/
    if (procedureBox.isEmpty) {
      try {
        SalatProcedureModel? salatProcedureData = await Repositories().salatProcedureData();

        if (salatProcedureData != null) {
          await procedureBox.put('salatProcedure', salatProcedureModelToJson(salatProcedureData));
        } else {
          debugPrint('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   null   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        }
      } catch (e) {
        debugPrint("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
        log("  salatProcedureData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }

      /*-------------------------Wudu Procedure----------------------*/

      try {
        List<WuduProcedureModel> wuduProcedureData = await Repositories().getOzuProcedureData();

        await procedureBox.put('wuduProcedure', wuduProcedureModelToJson(wuduProcedureData));
      } catch (e) {
        log("  getOzuProcedureData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }

      /*-------------------------Janaja Procedure----------------------*/

      try {
        List<JanajaProcedureModel> janajaProcedureData = await Repositories().getJanajaProcedureData();

        await procedureBox.put('janajaProcedure', janajaProcedureModelToJson(janajaProcedureData));
      } catch (e) {
        log("  getJanajaProcedureData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }

      // /*-------------------------Jumma Procedure----------------------*/

      try {
        List<JummaProcedureModel> jummaNamazProcedure = await Repositories().getJummaProcedureData();
        await procedureBox.put('jummaProcedure', jummaProcedureModelToJson(jummaNamazProcedure));
      } catch (e) {
        log("  getJummaProcedureData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }

      /*-------------------------Eid Procedure----------------------*/
      try {
        List<EidProcedureModel> eidProcedureData = await Repositories().getEidProcedureData();
        await procedureBox.put('eidProcedure', eidProcedureModelToJson(eidProcedureData));
      } catch (e) {
        log("  getEidProcedureData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    if (doaBox.isEmpty) {
      /*--------------------------Set Doa Data----------------- */
      try {
        List<DoaModel> doaData = await Repositories().getDoa();
        await doaBox.put("doabox", doaModelToJson(doaData));
      } catch (e) {
        log("  getDoa  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    if (greetingBox.isEmpty) {
      /*--------------------------Set Greetings Data----------------- */
      try {
        List<GreetingsModel> greetingsData = await Repositories().getGreetingsData();
        await greetingBox.put("greetingsBox", greetingsModelToJson(greetingsData));
      } catch (e) {
        log("  getGreetingsData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    if (fivePilarOfIslam.isEmpty) {
      /*--------------------------Set Five Pillars of Islam Data----------------- */
      try {
        List<FivePillarsOfIslamModel> fivePillarsData = await Repositories().getFivePillarsOfIslamData();
        await fivePilarOfIslam.put("fivePillarsDataBox", fivePillarsOfIslamModelToJson(fivePillarsData));
      } catch (e) {
        log("  getFivePillarsOfIslamData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    if (namesDataBox.isEmpty) {
      /*---------------Set boys Name Data----------------- */
      try {
        List<NameModel> boysNameData = await Repositories().getBoysName();
        await Boxes().namesDataBox.put("boysName", nameModelToJson(boysNameData));
      } catch (e) {
        log("  getBoysName  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }

      /*---------------Set Girls Name Data----------------- */
      try {
        List<NameModel> girlsNameData = await Repositories().getGirlsName();
        await Boxes().namesDataBox.put("girlsName", nameModelToJson(girlsNameData));
      } catch (e) {
        log("  getGirlsName  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    if (qurbaniDataBox.isEmpty) {
      /*--------------------------Set Qurbani Data----------------- */
      try {
        List<QurbaniModel> qurbaniData = await Repositories().getQurbaniData();
        await Boxes().qurbaniDataBox.put("qurbaniDataBox", qurbaniModelToJson(qurbaniData));
      } catch (e) {
        log("  getQurbaniData  ");
        return Future.value(ApiStatusModel(errorMsg: e.toString(), isSuccess: false));
      }
    }
    return Future.value(ApiStatusModel(errorMsg: '', isSuccess: true));
  }
}
