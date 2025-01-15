import 'package:easy_localization/easy_localization.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/all_doa_bloc/doa_screen_bloc/doa_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/common_widgets/turn_on_location_widget.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/widgets/doas_doa.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/ramadan_card_section.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class RamadanScreen extends StatefulWidget {
  const RamadanScreen({super.key});

  @override
  State<RamadanScreen> createState() => _RamadanScreenState();
}

class _RamadanScreenState extends State<RamadanScreen> {
  final utilsBox = Boxes().utilsBox;
  late String locale;
  String formattedDate = '';
  String fajr = '';
  String sahariTime = '';
  String maghrib = '';
  String iftarTime = '';
  List<Map<String, dynamic>> prayerData = [];
  // String ramadanDateTime = 'Some Hijri Date';
  final lat = Boxes().utilsBox.get('lat');
  final long = Boxes().utilsBox.get('long');
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = Localizations.localeOf(context).languageCode;
    // Now that locale is initialized, call the methods that depend on it
    if (lat != null && long != null) {
      _sahriIftarTime();
      generateSahriIftarTime();
    }
  }

  @override
  void initState() {
    super.initState();
    if (lat != null && long != null) {
      BlocProvider.of<DoaScreenBloc>(context).add(DoaScreenLoadedRamadanEvent());
    }
  }

  Future<void> generateSahriIftarTime() async {
    final lat = utilsBox.get('lat');
    final long = utilsBox.get('long');

    for (var i = 0; i < 5; i++) {
      DateTime dateTime = DateTime.now().add(Duration(days: i));
      formattedDate = DateFormat('E, d MMM', locale).format(dateTime);
      final prayerTimes = CommonFunctions.getPrayerTime(lat, long, dateTime);
      fajr = DateFormat('h:mm a', locale).format(prayerTimes.fajr);
      maghrib = DateFormat('h:mm a').format(prayerTimes.maghrib);
      // Extending 3 minutes for BD only
      if (prayerTimes.maghrib.timeZoneName == '+06') {
        maghrib = DateFormat('h:mm a', locale).format(prayerTimes.maghrib.add(const Duration(minutes: 3)));
      }

      Map<String, dynamic> data = {
        "Date": formattedDate,
        "fajr": fajr,
        "maghrib": maghrib,
      };

      prayerData.add(data);
    }
  }

  void _sahriIftarTime() {
    DateTime dateTime = DateTime.now();
    final prayerTimes = CommonFunctions.getPrayerTime(lat, long, dateTime);
    sahariTime = DateFormat('h:mm a', locale).format(prayerTimes.fajr);
    iftarTime = DateFormat('h:mm a', locale).format(prayerTimes.maghrib);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('EEEE, d MMMM y', locale).format(now);
    // bool isRamadan = Boxes().syncBox.get('is_ramadan');
    // Replace with actual hijri date logic

    return Scaffold(
      appBar: customAppBar("sehri_and_iftar".tr(), true, [], kStyleTextW500CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: lat != null && long != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const RamadanCardSection(),
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          date,
                                          style: kStyleTextW500CP.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ramadanDateTime,
                                          style: kStyleTextW400CB.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "upcoming_date".tr(),
                                          textAlign: TextAlign.start,
                                          style: kStyleTextW500CP.copyWith(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "sahari_time".tr(),
                                          textAlign: TextAlign.start,
                                          style: kStyleTextW500CP.copyWith(fontSize: 14.sp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "iftar_time".tr(),
                                          textAlign: TextAlign.start,
                                          style: kStyleTextW500CP.copyWith(fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: prayerData.length,
                                      itemBuilder: (context, index) {
                                        var item = prayerData[index];
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 10,
                                                  child: Text(
                                                    '${item['Date']}',
                                                    textAlign: TextAlign.start,
                                                  )),
                                              Expanded(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                                    child: Text(
                                                      '${item['fajr']}',
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                                    child: Text(
                                                      '${item['maghrib']}',
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "dua_related_fasting".tr(),
                              style: kStyleTextW400CG.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        BlocBuilder<DoaScreenBloc, DoaScreenState>(
                          builder: (context, state) {
                            if (state is DoaScreenLodedRamadanState) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: state.ramadan.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 5.w, left: 6.w, right: 8.w),
                                      decoration: BoxDecoration(color: kColorWhite, borderRadius: BorderRadius.circular(5)),
                                      child: ListTile(
                                        onTap: () => Navigator.of(context).push(CustomPageRoute(
                                          child: DoasDoa(
                                            oindex: index,
                                            doas: state.ramadan[index].data,
                                            title: state.ramadan[index].subCategoryInBangla,
                                          ),
                                          direction: AxisDirection.left,
                                        )),
                                        title: Text(
                                          state.ramadan[index].subCategoryInBangla,
                                          style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14.sp,
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: DefaultCircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const TurnOnLocationWidget(),
    );
  }
}
