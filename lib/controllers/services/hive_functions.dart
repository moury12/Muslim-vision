import 'package:hive_flutter/hive_flutter.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/models/doa_model.dart';
import 'package:muslim_vision/models/eid_procedure_model.dart';
import 'package:muslim_vision/models/five_pillars_of_islam_model.dart';
import 'package:muslim_vision/models/greetings_model.dart';
import 'package:muslim_vision/models/janaja_procedure_model.dart';
import 'package:muslim_vision/models/jumma_procedure_model.dart';
import 'package:muslim_vision/models/qurbani_model.dart';
import 'package:muslim_vision/models/salat_procedure_model.dart';
import 'package:muslim_vision/models/wudu_procedure_model.dart';

class HiveFunctions {
  final Box<dynamic> procedureBox = Boxes().procedureBox;

  SalatProcedureModel getSalatProcedureModelFromHive() {
    final String data = procedureBox.get('salatProcedure');
    return salatProcedureModelFromJson(data);
  }

  List<WuduProcedureModel> getWuduProcedureDataFromHive() {
    final String data = procedureBox.get('wuduProcedure');
    return wuduProcedureModelFromJson(data);
  }

  List<JanajaProcedureModel> getJanajaProcedureDataFromHive() {
    final String data = procedureBox.get('janajaProcedure');
    return janajaProcedureModelFromJson(data);
  }

  List<JummaProcedureModel> getJummaProcedureDataFromHive() {
    final String data = procedureBox.get('jummaProcedure');
    return jummaProcedureModelFromJson(data);
  }

  List<EidProcedureModel> getEidProcedureDataFromHive() {
    final String data = procedureBox.get('eidProcedure');
    return eidProcedureModelFromJson(data);
  }

  //************************* Get Greetings Data From Hive****************** */

  List<GreetingsModel> getGreetingsDatafromHive() {
    final Box<dynamic> greetingsBox = Boxes().greetingsBox;

    final String data = greetingsBox.get('greetingsBox').toString();

    return greetingsModelFromJson(data);
  }

  //************************* Get Doa Data From Hive****************** */

  List<DoaModel> getDoasDatafromHive() {
    final Box<dynamic> doabox = Boxes().doaBox;

    final String data = doabox.get('doabox').toString();

    return doaModelFromJson(data);
  }

  //************************* Get Five Pillars of Islam Data From Hive****************** */

  List<FivePillarsOfIslamModel> getFivePillarsOfIslamDatafromHive() {
    final Box<dynamic> fivePillarsDataBox = Boxes().fivePillarsDataBox;

    final String fivePillars = fivePillarsDataBox.get('fivePillarsDataBox').toString();

    return fivePillarsOfIslamModelFromJson(fivePillars);
  }

  //************************* Get Qurbani Data From Hive****************** */

  List<QurbaniModel> getQurbaniDatafromHive() {
    final Box<dynamic> qurbaniDataBox = Boxes().qurbaniDataBox;

    final String qurbani = qurbaniDataBox.get('qurbaniDataBox').toString();

    return qurbaniModelFromJson(qurbani);
  }
}
