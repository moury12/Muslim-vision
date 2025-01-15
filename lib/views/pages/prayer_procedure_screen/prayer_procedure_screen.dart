import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_top_card_zone_bloc/home_screen_card_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_button_widget.dart';
import 'package:muslim_vision/views/common_widgets/turn_on_location_widget.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/eid_procedure_screen/eid_procedure_screen.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/janaja_procedure_screen/janaja_procedure_screen.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/jumma_procedure_screen/jumma_procedure_screen.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_widgets/prayer_procedure_single_row.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_widgets/prayer_procedure_types_of_salah.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_widgets/salah_wise_popup.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/wudu_procedure_screen/wudu_procedure_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../database/boxes.dart';
import '../../common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

class PrayerProcedureScreen extends StatefulWidget {
  const PrayerProcedureScreen({Key? key}) : super(key: key);

  @override
  State<PrayerProcedureScreen> createState() => _PrayerProcedureScreenState();
}

class _PrayerProcedureScreenState extends State<PrayerProcedureScreen> {
  @override
  void initState() {
    super.initState();
  }

  final lat = Boxes().utilsBox.get('lat');
  final long = Boxes().utilsBox.get('long');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('prayer_procedure'.tr(), true, [], kStyleTextW600CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: lat != null && long != null
          ? Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: ListView(
                children: [
                  Column(
                    children: [
                      BlocBuilder<HomeScreenCardBloc, HomeScreenCardState>(
                        builder: (context, state) {
                          if (state is HomeScreenCardInitialState) {
                            return const Center(child: DefaultCircularProgressIndicator());
                          } else if (state is HomeScreenCardLoadedState) {
                            return Card(
                              surfaceTintColor: kColorWhite,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(color: kColorDeepGray, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)), border: Border.all(color: kColorDeepGray2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0).r,
                                      child: Row(
                                        children: [
                                          Text(
                                            "salah_rakat_chart".tr(),
                                            style: kStyleTextW600CP.copyWith(fontSize: 16.sp),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                            prayer_pro_title_img,
                                            height: 25.h,
                                            width: 25.w,
                                            fit: BoxFit.cover,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0).r,
                                    child: Column(
                                      children: [
                                        const PrayerProcedureTypesOfSalah(),
                                        PrayerProcedureSingleRow(
                                            waktName: 'Fajar',
                                            waktNametitle: 'Fajar',
                                            isActive: state.getWaktDetails['waqtName'] == 'Fazr' ? true : false,
                                            beforeSunnahRakatNumber: '2',
                                            beforeSunnahColor: kColorDeepYellow,
                                            farjRakatNumber: '2',
                                            farjColor: kColorPrimary,
                                            afterSunnahRakatNumber: 'X',
                                            afterSunnahColor: kColorGrey.withOpacity(0.3),
                                            wajibRakatNumber: 'X',
                                            wajibColor: kColorGrey.withOpacity(0.3)),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Duhur',
                                          waktNametitle: 'Duhur',
                                          isActive: DateFormat('EEEE').format(DateTime.now()) == "Friday"
                                              ? false
                                              : state.getWaktDetails['waqtName'] == 'Duhur'
                                                  ? true
                                                  : false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '4',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '2',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Asr',
                                          waktNametitle: 'Asr',
                                          isActive: state.getWaktDetails['waqtName'] == 'Asr' ? true : false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '4',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: 'X',
                                          afterSunnahColor: kColorGrey.withOpacity(0.3),
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Maghrib',
                                          waktNametitle: 'Maghrib',
                                          isActive: state.getWaktDetails['waqtName'] == 'Magrib' ? true : false,
                                          beforeSunnahRakatNumber: 'X',
                                          beforeSunnahColor: kColorGrey.withOpacity(0.3),
                                          farjRakatNumber: '3',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '2',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktNametitle: 'ishaa',
                                          waktName: 'Isha’a',
                                          isActive: state.getWaktDetails['waqtName'] == 'Isha' ? true : false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '4',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '2',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: '3',
                                          wajibColor: kColorBlue,
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Jummah',
                                          waktNametitle: 'Jummah',
                                          isActive: state.getWaktDetails['waqtName'] == 'Duhur' && DateFormat('EEEE').format(DateTime.now()) == "Friday" ? true : false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '2',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '4',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Card(
                              surfaceTintColor: kColorWhite,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(color: kColorDeepGray, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)), border: Border.all(color: kColorDeepGray2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0).r,
                                      child: Row(
                                        children: [
                                          Text(
                                            "salah_rakat_chart".tr(),
                                            style: kStyleTextW600CP.copyWith(fontSize: 16.sp),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                            prayer_pro_title_img,
                                            height: 25.h,
                                            width: 25.w,
                                            fit: BoxFit.cover,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0).r,
                                    child: Column(
                                      children: [
                                        const PrayerProcedureTypesOfSalah(),
                                        PrayerProcedureSingleRow(
                                            waktName: 'Fajar',
                                            waktNametitle: 'Fajar',
                                            isActive: false,
                                            beforeSunnahRakatNumber: '2',
                                            beforeSunnahColor: kColorDeepYellow,
                                            farjRakatNumber: '2',
                                            farjColor: kColorPrimary,
                                            afterSunnahRakatNumber: 'X',
                                            afterSunnahColor: kColorGrey.withOpacity(0.3),
                                            wajibRakatNumber: 'X',
                                            wajibColor: kColorGrey.withOpacity(0.3)),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Duhur',
                                          waktNametitle: 'Duhur',
                                          isActive: false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '4',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '2',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Asr',
                                          waktNametitle: 'Asr',
                                          isActive: false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '4',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: 'X',
                                          afterSunnahColor: kColorGrey.withOpacity(0.3),
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Maghrib',
                                          waktNametitle: 'Maghrib',
                                          isActive: false,
                                          beforeSunnahRakatNumber: 'X',
                                          beforeSunnahColor: kColorGrey.withOpacity(0.3),
                                          farjRakatNumber: '3',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '2',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                        Divider(height: 5.h),
                                        const PrayerProcedureSingleRow(
                                          waktNametitle: 'ishaa',
                                          waktName: 'Isha’a',
                                          isActive: false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '4',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '2',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: '3',
                                          wajibColor: kColorBlue,
                                        ),
                                        Divider(height: 5.h),
                                        PrayerProcedureSingleRow(
                                          waktName: 'Jummah',
                                          waktNametitle: 'Jummah',
                                          isActive: false,
                                          beforeSunnahRakatNumber: '4',
                                          beforeSunnahColor: kColorDeepYellow,
                                          farjRakatNumber: '2',
                                          farjColor: kColorPrimary,
                                          afterSunnahRakatNumber: '4',
                                          afterSunnahColor: kColorDeepYellow,
                                          wajibRakatNumber: 'X',
                                          wajibColor: kColorGrey.withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      Card(
                        surfaceTintColor: kColorWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0).r,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                      isPng: false,
                                      imageUrl: wudu,
                                      title: 'wudu'.tr(),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          CustomPageRoute(
                                            child: const WuduProcedureScreen(),
                                            direction: AxisDirection.left,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: salat,
                                        title: 'Fajr'.toLowerCase().tr(),
                                        onPressed: () {
                                          // print(CommonFunctions.getPrayerTime(Boxes().utilsBox.get('lat'), Boxes().utilsBox.get('long'), DateTime.now()).fajr.toString());
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SalahWisePopup(
                                                    context: context,
                                                    prayerTime: CommonFunctions.getPrayerTime(Boxes().utilsBox.get('lat'), Boxes().utilsBox.get('long'), DateTime.now()).fajr.toString(),
                                                    sunnah: '2',
                                                    totalRakat: '4',
                                                    waktName: 'Fajar',
                                                    waktNametitle: 'Fajar',
                                                    beforeSunnahRakatNumber: '2',
                                                    beforeSunnahColor: kColorDeepYellow,
                                                    farjRakatNumber: '2',
                                                    farjColor: kColorPrimary,
                                                    afterSunnahRakatNumber: 'X',
                                                    afterSunnahColor: kColorGrey.withOpacity(0.3),
                                                    wajibRakatNumber: 'X',
                                                    wajibColor: kColorGrey.withOpacity(0.3));
                                              });
                                        }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: salat,
                                        title: 'Duhur'.toLowerCase().tr(),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SalahWisePopup(
                                                  context: context,
                                                  prayerTime: CommonFunctions.getPrayerTime(Boxes().utilsBox.get('lat'), Boxes().utilsBox.get('long'), DateTime.now()).dhuhr.toString(),
                                                  sunnah: '4+2',
                                                  totalRakat: '10',
                                                  waktName: 'Duhur',
                                                  waktNametitle: 'Duhur',
                                                  beforeSunnahRakatNumber: '4',
                                                  beforeSunnahColor: kColorDeepYellow,
                                                  farjRakatNumber: '4',
                                                  farjColor: kColorPrimary,
                                                  afterSunnahRakatNumber: '2',
                                                  afterSunnahColor: kColorDeepYellow,
                                                  wajibRakatNumber: 'X',
                                                  wajibColor: kColorGrey.withOpacity(0.3),
                                                );
                                              });
                                        }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: salat,
                                        title: 'Asr'.toLowerCase().tr(),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SalahWisePopup(
                                                  context: context,
                                                  prayerTime: CommonFunctions.getPrayerTime(Boxes().utilsBox.get('lat'), Boxes().utilsBox.get('long'), DateTime.now()).asr.toString(),
                                                  sunnah: '4',
                                                  totalRakat: '8',
                                                  waktName: 'Asr',
                                                  waktNametitle: 'Asr',
                                                  beforeSunnahRakatNumber: '4',
                                                  beforeSunnahColor: kColorDeepYellow,
                                                  farjRakatNumber: '4',
                                                  farjColor: kColorPrimary,
                                                  afterSunnahRakatNumber: 'X',
                                                  afterSunnahColor: kColorGrey.withOpacity(0.3),
                                                  wajibRakatNumber: 'X',
                                                  wajibColor: kColorGrey.withOpacity(0.3),
                                                );
                                              });
                                        }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: salat,
                                        title: 'Maghrib'.toLowerCase().tr(),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SalahWisePopup(
                                                  context: context,
                                                  prayerTime: CommonFunctions.getPrayerTime(Boxes().utilsBox.get('lat'), Boxes().utilsBox.get('long'), DateTime.now()).maghrib.toString(),
                                                  sunnah: '2',
                                                  totalRakat: '5',
                                                  waktName: 'Maghrib',
                                                  waktNametitle: 'Maghrib',
                                                  beforeSunnahRakatNumber: 'X',
                                                  beforeSunnahColor: kColorGrey.withOpacity(0.3),
                                                  farjRakatNumber: '3',
                                                  farjColor: kColorPrimary,
                                                  afterSunnahRakatNumber: '2',
                                                  afterSunnahColor: kColorDeepYellow,
                                                  wajibRakatNumber: 'X',
                                                  wajibColor: kColorGrey.withOpacity(0.3),
                                                );
                                              });
                                        }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: salat,
                                        title: 'Isha'.toLowerCase().tr(),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SalahWisePopup(
                                                  context: context,
                                                  prayerTime: CommonFunctions.getPrayerTime(Boxes().utilsBox.get('lat'), Boxes().utilsBox.get('long'), DateTime.now()).isha.toString(),
                                                  sunnah: '6',
                                                  totalRakat: '13',
                                                  waktName: 'Isha’a',
                                                  waktNametitle: 'ishaa',
                                                  beforeSunnahRakatNumber: '4',
                                                  beforeSunnahColor: kColorDeepYellow,
                                                  farjRakatNumber: '4',
                                                  farjColor: kColorPrimary,
                                                  afterSunnahRakatNumber: '2',
                                                  afterSunnahColor: kColorDeepYellow,
                                                  wajibRakatNumber: '3',
                                                  wajibColor: kColorBlue,
                                                );
                                              });
                                        }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: witir,
                                        title: 'Witir'.toLowerCase().tr(),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/salatProcedure',
                                            arguments: {
                                              'waktName': 'Isha’a',
                                              'waktNametitle': 'Witir',
                                              'rakatType': 'wajib',
                                              'rakatNumber': '3',
                                            },
                                          );
                                        }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                      isPng: false,
                                      imageUrl: jummah,
                                      title: 'Jummah'.toLowerCase().tr(),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          CustomPageRoute(
                                            child: const JummaProcedureScreen(),
                                            direction: AxisDirection.left,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                      isPng: false,
                                      imageUrl: eid,
                                      title: 'Eid'.toLowerCase().tr(),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          CustomPageRoute(
                                            child: const EidProcedureScreen(),
                                            direction: AxisDirection.left,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: CustomButtonWidget(
                                        isPng: false,
                                        imageUrl: prohibitedTimes,
                                        title: 'Janaza'.toLowerCase().tr(),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            CustomPageRoute(
                                              child: const JanajaProcedureScreen(),
                                              direction: AxisDirection.left,
                                            ),
                                          );
                                        }),
                                  ),
                                  const Flexible(fit: FlexFit.tight, child: Text('')),
                                  const Flexible(fit: FlexFit.tight, child: Text('')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const TurnOnLocationWidget(),
    );
  }
}
