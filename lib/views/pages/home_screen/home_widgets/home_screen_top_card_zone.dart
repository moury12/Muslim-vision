import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/home_bloc/prohibited-prayer-bloc/prohibeted_prayer_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../../blocs/home_bloc/home_screen_top_card_zone_bloc/home_screen_card_bloc.dart';

class HomeScreenTopCardZone extends StatefulWidget {
  const HomeScreenTopCardZone({super.key});

  @override
  State<HomeScreenTopCardZone> createState() => _HomeScreenTopCardZoneState();
}

class _HomeScreenTopCardZoneState extends State<HomeScreenTopCardZone> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenCardBloc>(context).add(HomeScreenCardLoadedEvent());
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  final lat = Boxes().utilsBox.get('lat');
  final long = Boxes().utilsBox.get('long');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCardBloc, HomeScreenCardState>(
      listener: (context, state) {
        if (state is HomeScreenCardLoadedState) {
          DateTime? waqtLeft = state.getWaktDetails['waqtTimeLeft'];
          bool isProhibited = state.getWaktDetails['is_prohibited'];
          String wakName = state.getWaktDetails['waqtName'];
          // DateTime? startTime = state.getWaktDetails['startTime'];
          // print(startTime.toString());
          // print(DateTime.now());
          timer?.cancel(); // Cancel existing timer if any
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (waqtLeft != null /*||(isProhibited&& DateTime.now()==startTime)*/) {
              Duration difference = waqtLeft.difference(DateTime.now());
              context.read<HomeScreenCardBloc>().add(HomeScreenCardWaktLeftTimerEvent(
                    waqtTimedetails: state.getWaktDetails,
                  ));
              if (isProhibited == true && wakName == 'prohibited_sunrise') {
                context.read<ProhibetedPrayerBloc>().add(ProhibetedPrayerLoadedEvent(isSunrise: true));
              }
              if (isProhibited == true && wakName == 'prohibited_zenith') {
                context.read<ProhibetedPrayerBloc>().add(ProhibetedPrayerLoadedEvent(isZenith: true));
              }
              if (isProhibited == true && wakName == 'prohibited_sunset') {
                context.read<ProhibetedPrayerBloc>().add(ProhibetedPrayerLoadedEvent(isSunset: true));
              }
              if (difference.inSeconds <= 0) {
                context.read<HomeScreenCardBloc>().add(
                      HomeScreenCardLoadedEvent(),
                    );
                context.read<ProhibetedPrayerBloc>().add(ProhibetedPrayerLoadedEvent(
                      isSunrise: false,
                      isSunset: false,
                      isZenith: false,
                    ));
              }
            }
          });
        }
      },
      builder: (context, state) {
        if (state is HomeScreenCardInitialState) {
          return const DefaultCircularProgressIndicator();
        } else if (state is HomeScreenCardNoLocationState) {
          return Container(
            padding: EdgeInsets.only(top: 22.h, left: 6.5.w, right: 6.5.w),
            decoration: const BoxDecoration(
              image: DecorationImage(scale: 2, image: AssetImage(cardZone), fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: lat == null && long == null
                              ? () async {
                                  await CommonFunctions().processLocationPermission(context, false);
                                }
                              : null,
                          child: Text("enable_location".tr(), style: kStyleTextW500CW.copyWith(fontSize: 19.sp, height: 0.6.h)),
                        ))),
                Expanded(
                    flex: 3,
                    child: Text(context.locale.toString() == 'en' ? 'waqt Time' : convertToBanglaNumber('00:00 AM'),
                        style: kStyleTextW700CW.copyWith(
                          fontSize: 32.sp,
                        ))),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${'will_end'.tr()} - ${context.locale.toString() == 'en' ? '00:00:00' : convertToBanglaNumber('00:00:00')} ${'minutes'.tr()}',
                        style: kStyleTextW400CW.copyWith(fontSize: 11.sp),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: 'rakat'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                              TextSpan(text: '${context.locale.toString() == 'en' ? '0' : convertToBanglaNumber('0')}  |  ', style: kStyleTextW600CW.copyWith(fontSize: 11.sp)),
                              TextSpan(text: 'farz'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                              TextSpan(text: '${"enable_location".tr()}  |  ', style: kStyleTextW600CW.copyWith(fontSize: 11.sp)),
                              TextSpan(text: 'sunnah'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                              TextSpan(text: context.locale.toString() == 'en' ? '0' : convertToBanglaNumber('0'), style: kStyleTextW600CW.copyWith(fontSize: 11.sp)),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor:kColorGreen2 ,
                          side: const BorderSide(color: kColorPrimary),
                          minimumSize: Size(100.w, 30.h),
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                              child: const PrayerProcedureScreen(),
                              direction: AxisDirection.left,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text(
                            'how_to_pray'.tr(),
                            style: kStyleTextW500CW.copyWith(fontSize: 10.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (state is HomeScreenCardLoadedState) {
          String formattedDifference = '00:00:00';
          if (state.getWaktDetails['waqtTimeLeft'] != null) {
            Duration? difference = state.getWaktDetails['waqtTimeLeft'].difference(DateTime.now());
            formattedDifference = difference != null ? DateFormat('HH:mm:ss').format(DateTime(0).add(difference)) : '00:00:00';
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              padding: EdgeInsets.only(top: 22.h, left: 6.5.w, right: 6.5.w),
              decoration: BoxDecoration(
                image: DecorationImage(scale: 2, image: AssetImage(state.getWaktDetails['is_prohibited'] ? 'assets/images/prohibited_background.png' : cardZone), fit: BoxFit.fill),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(DateFormat('EEEE').format(DateTime.now()) == "Friday" && state.getWaktDetails['waqtName'] == 'Duhur' ? "jummah".tr() : state.getWaktDetails['waqtName'].toString().toLowerCase().tr(), style: kStyleTextW500CW.copyWith(fontSize: 19.sp, height: 0.6.h)))),
                  Expanded(
                      flex: 3,
                      child: Text(context.locale.toString() == 'en' ? state.getWaktDetails['waqtTime'].toString().toUpperCase() : convertToBanglaNumber(state.getWaktDetails['waqtTime'].toString().toUpperCase()),
                          style: kStyleTextW700CW.copyWith(
                            fontSize: 32.sp,
                          ))),
                  Expanded(
                      flex: 2,
                      child: Text(
                        '${'will_end'.tr()} - ${context.locale.toString() == 'en' ? formattedDifference : convertToBanglaNumber(formattedDifference)} ${'minutes'.tr()}',
                        style: kStyleTextW400CW.copyWith(fontSize: 11.sp),
                      )),
                  state.getWaktDetails['is_prohibited']
                      ? const SizedBox.shrink()
                      : Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: 'rakat'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                      TextSpan(text: '${context.locale.toString() == 'en' ? state.getWaktDetails['totalRakat'] : convertToBanglaNumber(state.getWaktDetails['totalRakat'])}  |  ', style: kStyleTextW600CW.copyWith(fontSize: 11.sp)),
                                      TextSpan(text: 'farz'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                      TextSpan(text: '${context.locale.toString() == 'en' ? state.getWaktDetails['farz'] : convertToBanglaNumber(state.getWaktDetails['farz'])}  |  ', style: kStyleTextW600CW.copyWith(fontSize: 11.sp)),
                                      TextSpan(text: 'sunnah'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                      TextSpan(text: context.locale.toString() == 'en' ? state.getWaktDetails['sunnah'] : convertToBanglaNumber(state.getWaktDetails['sunnah']), style: kStyleTextW600CW.copyWith(fontSize: 11.sp)),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: state.getWaktDetails['is_prohibited'] ? const Color(0xffEB0000) : kColorPrimary,
                                  side: BorderSide(color: state.getWaktDetails['is_prohibited'] ? const Color(0xffEB0000) : kColorPrimary),
                                  minimumSize: Size(100.w, 30.h),
                                  padding: const EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    CustomPageRoute(
                                      child: const PrayerProcedureScreen(),
                                      direction: AxisDirection.left,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    'how_to_pray'.tr(),
                                    style: kStyleTextW500CW.copyWith(fontSize: 10.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
