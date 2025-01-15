// // ignore_for_file: depend_on_referenced_packages

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:meta/meta.dart';
// import 'package:muslim_vision/controllers/services/static_data.dart';
// import 'package:muslim_vision/models/doa_model.dart';
// import 'package:muslim_vision/models/five_pillars_of_islam_model.dart';
// import 'package:muslim_vision/models/greetings_model.dart';
// import 'package:muslim_vision/models/janaja_procedure_model.dart';
// import 'package:muslim_vision/models/name_model.dart';
// import 'package:muslim_vision/models/qurbani_model.dart';

// import '../../controllers/repositories.dart';
// import '../../controllers/services/common_functions.dart';
// import '../../database/boxes.dart';
// import '../../models/eid_procedure_model.dart';
// import '../../models/jumma_procedure_model.dart';
// import '../../models/salat_procedure_model.dart';
// import '../../models/wudu_procedure_model.dart';

// part 'splash_screen_event.dart';

// part 'splash_screen_state.dart';

// class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
//   SplashScreenBloc() : super(SplashScreenInitialState()) {

//     final dmPath = Boxes().dmPath;
//     final Box<dynamic> procedureBox = Boxes().procedureBox;
//     final Box dhikrBox = Boxes().tasbeehBox;
//     final Box namesOfAllahBox = Boxes().namesOfAllahBox;
//     final utilBox = Boxes().utilsBox;
//     final isAdded = Boxes().isAdded;


//     on<SplashScreenLoadedEvent>((event, emit) async {
//       /*-------------------------get DM Path----------------------*/
//       if (dmPath.isEmpty) {
//         await Repositories().getDMPathData();
//       }
//       /*-------------------------get user location----------------------*/
//       Position currentPosition = await CommonFunctions().determinePosition();
//       /*-------------------------get city name----------------------*/
//       List<Placemark>? placeMarks = await CommonFunctions().getCityName(currentPosition);
//       if (placeMarks == null) {
//         return;
//       }
//       String? city = placeMarks[0].locality;
//       //----------------------------------------------------------
//       if (utilBox.isEmpty || city != utilBox.get('city')) {
//         utilBox.put('lat', currentPosition.latitude);
//         utilBox.put('long', currentPosition.longitude);
//         utilBox.put('city', city);
//       }
//       /*-------------------------Is Added----------------------*/
//       isAdded.put('isHomeScreenAbove99NamesAdEnabled', true);
//       isAdded.put('isHomeScreenBelow99NamesAdEnabled', true);
//       isAdded.put('isMoreScreenAdEnabled', true);
//       /*-------------------------Is Added----------------------*/
//       /*-----------------------------------------------------------------*/
//       /*-------------------------Dhikr Works Start----------------------*/
//       if (dhikrBox.isEmpty) {
//         await dhikrBox.put(StaticData().thirdDhikr['name'], StaticData().thirdDhikr);
//         await dhikrBox.put(StaticData().secondDhikr['name'], StaticData().secondDhikr);
//         await dhikrBox.put(StaticData().firstDhikr['name'], StaticData().firstDhikr);
//         await dhikrBox.put('TasbeehInitialData', {
//           'counter': 0,
//           'loop': 1,
//           'singleDhikrData': StaticData().firstDhikr,
//         });
//       }
//       if (dhikrBox.get('TasbeehInitialData').values.isEmpty) {
//         await dhikrBox.put('TasbeehInitialData', {
//           'counter': 0,
//           'loop': 1,
//           'singleDhikrData': StaticData().firstDhikr,
//         });
//       }

//       /*-------------------------Names Of Allah Start----------------------*/
//       if (namesOfAllahBox.values.isEmpty) {
//         await Repositories().getNamesOfAllahData();
//       }
//       /*-------------------------Procedure Start----------------------*/
//       if (procedureBox.isNotEmpty) {
//         emit(SplashScreenLoadedState());
//         return;
//       }
//       /*-------------------------Salat Procedure----------------------*/
//       SalatProcedureModel? salatProcedureData = await Repositories().salatProcedureData();
//       if (salatProcedureData == null) {
//         return;
//       }
//       await procedureBox.put('salatProcedure', salatProcedureModelToJson(salatProcedureData));

//       /*-------------------------Wudu Procedure----------------------*/
//       List<WuduProcedureModel> wuduProcedureData = await Repositories().getOzuProcedureData();
//       if (wuduProcedureData.isEmpty) {
//         return;
//       }
//       await procedureBox.put('wuduProcedure', wuduProcedureModelToJson(wuduProcedureData));

//       /*-------------------------Janaja Procedure----------------------*/
//       List<JanajaProcedureModel> janajaProcedureData = await Repositories().getJanajaProcedureData();
//       if (janajaProcedureData.isEmpty) {
//         return;
//       }
//       await procedureBox.put('janajaProcedure', janajaProcedureModelToJson(janajaProcedureData));
//       /*-------------------------Jumma Procedure----------------------*/
//       List<JummaProcedureModel> jummaNamazProcedure = await Repositories().getJummaProcedureData();
//       if (jummaNamazProcedure.isEmpty) {
//         return;
//       }
//       await procedureBox.put('jummaProcedure', jummaProcedureModelToJson(jummaNamazProcedure));
//       /*-------------------------Eid Procedure----------------------*/
//       List<EidProcedureModel> eidProcedureData = await Repositories().getEidProcedureData();
//       if (eidProcedureData.isEmpty) {
//         return;
//       }
//       await procedureBox.put('eidProcedure', eidProcedureModelToJson(eidProcedureData));
//       /*--------------------------Set Doa Data----------------- */
//       if (Boxes().doaBox.isNotEmpty) {
//         return;
//       } else {
//         List<DoaModel> doaData = await Repositories().getDoa();
//         await Boxes().doaBox.put("doabox", doaModelToJson(doaData));
//       }

//       /*--------------------------Set Greetings Data----------------- */
//       if (Boxes().greetingsBox.isNotEmpty) {
//         return;
//       } else {
//         List<GreetingsModel> greetingsData = await Repositories().getGreetingsData();
//         await Boxes().greetingsBox.put("greetingsBox", greetingsModelToJson(greetingsData));
//       }

//       /*--------------------------Set Five Pillars of Islam Data----------------- */
//       if (Boxes().fivePillarsDataBox.isNotEmpty) {
//         return;
//       } else {
//         List<FivePillarsOfIslamModel> fivePillarsData = await Repositories().getFivePillarsOfIslamData();
//         await Boxes().fivePillarsDataBox.put("fivePillarsDataBox", fivePillarsOfIslamModelToJson(fivePillarsData));
//       }

//       /*--------------------------Set Name Data----------------- */
//       if (Boxes().namesDataBox.isNotEmpty) {
//         return;
//       } else {
//         /*---------------Set boys Name Data----------------- */
//         List<NameModel> boysNameData = await Repositories.getBoysName();
//         await Boxes().namesDataBox.put("boysName", nameModelToJson(boysNameData));
//         /*---------------Set Girls Name Data----------------- */
//         List<NameModel> girlsNameData = await Repositories.getGirlsName();
//         await Boxes().namesDataBox.put("girlsName", nameModelToJson(girlsNameData));
//       }

//       /*--------------------------Set Qurbani Data----------------- */
//       if (Boxes().qurbaniDataBox.isNotEmpty) {
//         return;
//       } else {
//         List<QurbaniModel> qurbaniData = await Repositories().getQurbaniData();
//         await Boxes().qurbaniDataBox.put("qurbaniDataBox", qurbaniModelToJson(qurbaniData));
//       }

//       emit(SplashScreenLoadedState());
//     });
//   }
// }
