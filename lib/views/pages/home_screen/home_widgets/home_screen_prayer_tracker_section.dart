import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_prayer_tracker_bloc/home_screen_prayer_tracker_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class HomeScreenPrayerTrackerSection extends StatefulWidget {
  const HomeScreenPrayerTrackerSection({
    super.key,
  });

  @override
  State<HomeScreenPrayerTrackerSection> createState() => _HomeScreenPrayerTrackerSectionState();
}

class _HomeScreenPrayerTrackerSectionState extends State<HomeScreenPrayerTrackerSection> {
  final utilsBox = Boxes().utilsBox;
  String fajar = '';
  String duhur = '';
  String asr = '';
  String maghrib = '';
  String isha = '';
  final lat = Boxes().utilsBox.get('lat');
  final long = Boxes().utilsBox.get('long');
  _fiveOktoNamazTime() {
    DateTime dateTime = DateTime.now();
    final prayerTimes = CommonFunctions.getPrayerTime(lat, long, dateTime);
    fajar = DateFormat('h:mm a').format(prayerTimes.fajr);
    duhur = DateFormat('h:mm a').format(prayerTimes.dhuhr);
    asr = DateFormat('h:mm a').format(prayerTimes.asr);
    maghrib = DateFormat('h:mm a').format(prayerTimes.maghrib);
    isha = DateFormat('h:mm a').format(prayerTimes.isha);
  }

  @override
  void initState() {
    super.initState();
    if (utilsBox.get('lat') != null && utilsBox.get('long') != null) {
      _fiveOktoNamazTime();
    }
    BlocProvider.of<HomeScreenPrayerTrackerBloc>(context).add(HomeScreenPrayerTrackerLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (utilsBox.get('lat') != null && utilsBox.get('long') != null) {
          Navigator.pushAndRemoveUntil(
              context,
              CustomPageRoute(
                child: BottomNavBar(
                  index: 2,
                ),
                direction: AxisDirection.left,
              ),
              (route) => false);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(salatTracker),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0).w,
          child: Column(
            children: [
              /* utilsBox.get('lat') != null && utilsBox.get('long') != null? */ Row(
                children: [
                  Text(
                    'prayer_tracker'.tr(),
                    style: kStyleTextW600CW.copyWith(fontSize: 12.sp),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: kColorWhite,
                    size: 14.0.w,
                  )
                ],
              ) /*:SizedBox.shrink()*/,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0).h,
                child: BlocBuilder<HomeScreenPrayerTrackerBloc, HomeScreenPrayerTrackerState>(
                  builder: (context, state) {
                    if (state is HomeScreenPrayerTrackerInitialState) {
                      return const DefaultCircularProgressIndicator();
                    } else if (state is HomeScreenPrayerTrackerNoLocationState) {
                      return Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0).r,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 35.h,
                                  width: 250.w,
                                  child: Row(
                                    children: List.generate(
                                      120 ~/ 2,
                                      (index) => Expanded(
                                        child: Container(
                                          color: index % 2 == 0 ? Colors.transparent : kColorPrimary.withOpacity(0.5),
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            CommonFunctions().ShowMessage(context, ContentType.warning, "enable_location".tr(), "prayer_tracker_location".tr());
                                          },
                                          child: SvgPicture.asset(
                                            nonTick,
                                            height: 38.h,
                                            width: 38.w,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                        child: Text(
                                          'fajr'.tr(),
                                          style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                        ),
                                      ),
                                      Text(
                                        '00:00 AM',
                                        style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            CommonFunctions().ShowMessage(context, ContentType.warning, "enable_location".tr(), "prayer_tracker_location".tr());
                                          },
                                          child: SvgPicture.asset(
                                            nonTick,
                                            height: 38.h,
                                            width: 38.w,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                        child: Text(
                                          'duhur'.tr(),
                                          style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                        ),
                                      ),
                                      Text(
                                        '00:00 AM',
                                        style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            CommonFunctions().ShowMessage(context, ContentType.warning, "enable_location".tr(), "prayer_tracker_location".tr());
                                          },
                                          child: SvgPicture.asset(
                                            nonTick,
                                            height: 38.h,
                                            width: 38.w,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                        child: Text(
                                          'asr'.tr(),
                                          style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                        ),
                                      ),
                                      Text(
                                        '00:00 AM',
                                        style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            CommonFunctions().ShowMessage(context, ContentType.warning, "enable_location".tr(), "prayer_tracker_location".tr());
                                          },
                                          child: SvgPicture.asset(
                                            nonTick,
                                            height: 38.h,
                                            width: 38.w,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                        child: Text(
                                          'magrib'.tr(),
                                          style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                        ),
                                      ),
                                      Text(
                                        '00:00 AM',
                                        style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            CommonFunctions().ShowMessage(context, ContentType.warning, "enable_location".tr(), "prayer_tracker_location".tr());
                                          },
                                          child: SvgPicture.asset(
                                            nonTick,
                                            height: 38.h,
                                            width: 38.w,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                        child: Text(
                                          'isha'.tr(),
                                          style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                        ),
                                      ),
                                      Text(
                                        '00:00 AM',
                                        style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is HomeScreenPrayerTrackerLoadedState) {

                      if (lat != null) {
                        _fiveOktoNamazTime();
                      }
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: (() {}),
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0).r,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 35.h,
                                    width: 250.w,
                                    child: Row(
                                      children: List.generate(
                                        120 ~/ 2,
                                        (index) => Expanded(
                                          child: Container(
                                            color: index % 2 == 0 ? Colors.transparent : kColorPrimary.withOpacity(0.5),
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              if (!CommonFunctions().isWatkTime(fajar, DateTime.now())) {
                                                CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "");
                                              } else {
                                                BlocProvider.of<HomeScreenPrayerTrackerBloc>(context).add(PrayerButtonEvent("f"));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              state.rakat[0] ? tick : nonTick,
                                              height: 38.h,
                                              width: 38.w,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                          child: Text(
                                            'fajr'.tr(),
                                            style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                          ),
                                        ),
                                        Text(
                                          context.locale.toString() == 'en' ? state.waktTimes[0] : convertToBanglaNumber(state.waktTimes[0]),
                                          style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              if (!CommonFunctions().isWatkTime(duhur, DateTime.now())) {
                                                CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "");
                                              } else {
                                                BlocProvider.of<HomeScreenPrayerTrackerBloc>(context).add(PrayerButtonEvent("j"));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              state.rakat[1] ? tick : nonTick,
                                              height: 38.h,
                                              width: 38.w,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                          child: Text(
                                            'duhur'.tr(),
                                            style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                          ),
                                        ),
                                        Text(
                                          context.locale.toString() == 'en' ? state.waktTimes[1] : convertToBanglaNumber(state.waktTimes[1]),
                                          style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              if (!CommonFunctions().isWatkTime(asr, DateTime.now())) {
                                                CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "");
                                              } else {
                                                BlocProvider.of<HomeScreenPrayerTrackerBloc>(context).add(PrayerButtonEvent("a"));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              state.rakat[2] ? tick : nonTick,
                                              height: 38.h,
                                              width: 38.w,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                          child: Text(
                                            'asr'.tr(),
                                            style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                          ),
                                        ),
                                        Text(
                                          context.locale.toString() == 'en' ? state.waktTimes[2] : convertToBanglaNumber(state.waktTimes[2]),
                                          style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              if (!CommonFunctions().isWatkTime(maghrib, DateTime.now())) {
                                                CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "");
                                              } else {
                                                BlocProvider.of<HomeScreenPrayerTrackerBloc>(context).add(PrayerButtonEvent("m"));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              state.rakat[3] ? tick : nonTick,
                                              height: 38.h,
                                              width: 38.w,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                          child: Text(
                                            'magrib'.tr(),
                                            style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                          ),
                                        ),
                                        Text(
                                          context.locale.toString() == 'en' ? state.waktTimes[3] : convertToBanglaNumber(state.waktTimes[3]),
                                          style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              if (!CommonFunctions().isWatkTime(isha, DateTime.now())) {
                                                CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "");
                                              } else {
                                                BlocProvider.of<HomeScreenPrayerTrackerBloc>(context).add(PrayerButtonEvent("e"));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              state.rakat[4] ? tick : nonTick,
                                              height: 38.h,
                                              width: 38.w,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0).h,
                                          child: Text(
                                            'isha'.tr(),
                                            style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                          ),
                                        ),
                                        Text(
                                          context.locale.toString() == 'en' ? state.waktTimes[4] : convertToBanglaNumber(state.waktTimes[4]),
                                          style: kStyleTextW400CB.copyWith(fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


