// ignore_for_file: must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:muslim_vision/blocs/prayer_screen%20bloc/bloc/prayer_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/button_row.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_time_tracker_top_banner_section.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_tracke_calender.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/waqt_wise_tracker_section.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../common_widgets/turn_on_location_widget.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';


class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.05, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  void _startAnimation() {
    _controller.reset();
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 100), () async {
      await _controller.reverse();
    });
  }

  String preSelectedDate = '';

  final PrayerScreenBloc _pryerbloc = PrayerScreenBloc();

  bool _calendarShow = false;

  final utilsBox = Boxes().utilsBox;
  String fajar = '';
  String duhur = '';
  String asr = '';
  String maghrib = '';
  String isha = '';

  _fiveOktoNamazTime(DateTime date) {
    final lat = utilsBox.get('lat');
    final long = utilsBox.get('long');
    // DateTime dateTime = DateTime.now();
    final prayerTimes = CommonFunctions.getPrayerTime(lat, long, date);
    fajar = DateFormat('h:mm a').format(prayerTimes.fajr);
    duhur = DateFormat('h:mm a').format(prayerTimes.dhuhr);
    asr = DateFormat('h:mm a').format(prayerTimes.asr);
    maghrib = DateFormat('h:mm a').format(prayerTimes.maghrib);
    isha = DateFormat('h:mm a').format(prayerTimes.isha);
  }

  setStartSelectedDateForAnimation() {
    DateTime now = DateTime.now();
    DateTime formattedDateTime = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(formattedDateTime);
    preSelectedDate = formattedDate;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150), // Set the duration to 1 second
      vsync: this,
    );
    if (utilsBox.get('long') != null && utilsBox.get('lat') != null) {
      setStartSelectedDateForAnimation();
      _fiveOktoNamazTime(DateTime.now());
      _pryerbloc.add(PrayerCalendarButtonLoadingEvent());
      _calendarShow = !_calendarShow;
      _pryerbloc.add(PrayerCityCalendarToggleEvent());
    }
  }

  @override
  void dispose() {
    if (_controller.isAnimating) {
      _controller.stop(); // Stop the animation before disposing
    }
    _controller.dispose(); // Dispose safely
    _pryerbloc.close(); // Close the Bloc when no longer needed
    super.dispose(); // Call the super method last
  }

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

    String todayDateHijri = HijriCalendar.now().toFormat(
      'dd MMMM yyyy',
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kColorPrimary,
    ));
    return SafeArea(
      child: Scaffold(
        body: utilsBox.get('long') != null && utilsBox.get('lat') != null
            ? Column(
                children: [
                  customAppBar(
                    "prayer_tracker".tr(),
                    false,
                    [
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          _calendarShow = !_calendarShow;
                          _pryerbloc.add(PrayerCityCalendarToggleEvent());
                        },
                        child: SvgPicture.asset(
                          calendar,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                    kStyleTextW500CW.copyWith(fontSize: 16.sp),
                    context,
                    () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CustomPageRoute(
                            child: BottomNavBar(
                              index: 0,
                            ),
                            direction: AxisDirection.left,
                          ),
                          (route) => false);
                    },
                    showLeading: false,
                  ),
                  SizedBox(
                    height: 290.h,
                    child: BlocBuilder(
                      bloc: _pryerbloc,
                      buildWhen: (previous, current) => current is PrayerLoadingState || current is PrayerCalendarState,
                      builder: (context, state) {
                        if (state is PrayerScreenInitial || state is PrayerLoadingState) {
                          return const Center(child: DefaultCircularProgressIndicator());
                        } else if (state is PrayerCalendarState) {
                          return _calendarShow
                              ? SalatTrack(state.salatTrack, state.selectDate, (v) {
                                  _pryerbloc.add(PrayerDateClickEvent(v));
                                  if (DateTime.now().isBefore(v)) {
                                    _pryerbloc.add(DisableTrackClickEvent());
                                  }
                                })
                              : prayerScreenCardWidget(
                                  DateFormat('EEEE, d MMM, yyyy', locale).format(DateTime.now()),
                                  todayDateHijri,
                                );
                        } else {
                          return const DefaultCircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  BlocBuilder(
                    bloc: _pryerbloc,
                    buildWhen: (previous, current) => current is PrayerButtonsState || current is DisableButtonsState,
                    builder: (context, state) {
                      if (state is PrayerButtonsState) {
                        if (preSelectedDate != state.selectDate.toString()) {
                          _startAnimation();
                          preSelectedDate = state.selectDate.toString();
                        }

                        _fiveOktoNamazTime(state.selectDate);

                        return Expanded(
                          child: SlideTransition(
                            position: _offsetAnimation,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              padding: EdgeInsets.only(top: 8.w),
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.r),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                          child: SalatTrakerAndWakt(
                                        waktImage: fajr,
                                        waqtNmae: "fajar".tr(),
                                        time: fajar,
                                        check: state.rakat[0],
                                        function: () {
                                          if (!CommonFunctions().isWatkTime(fajar, state.selectDate)) {
                                            CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                          } else {
                                            _pryerbloc.add(PrayerButtonEvent("f"));
                                          }
                                        },
                                      )),
                                      Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                      Expanded(
                                          child: SalatTrakerAndWakt(
                                        waktImage: duhr,
                                        waqtNmae: "duhur".tr(),
                                        time: duhur,
                                        check: state.rakat[1],
                                        function: () {
                                          if (!CommonFunctions().isWatkTime(duhur, state.selectDate)) {
                                            CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                          } else {
                                            _pryerbloc.add(PrayerButtonEvent("j"));
                                          }
                                        },
                                      )),
                                      Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                      Expanded(
                                          child: SalatTrakerAndWakt(
                                        waktImage: asrW,
                                        waqtNmae: "asr".tr(),
                                        time: asr,
                                        check: state.rakat[2],
                                        function: () {
                                          if (!CommonFunctions().isWatkTime(asr, state.selectDate)) {
                                            CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                          } else {
                                            _pryerbloc.add(PrayerButtonEvent("a"));
                                          }
                                        },
                                      )),
                                      Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                      Expanded(
                                          child: SalatTrakerAndWakt(
                                        waktImage: magrib,
                                        waqtNmae: "maghrib".tr(),
                                        time: maghrib,
                                        check: state.rakat[3],
                                        function: () {
                                          if (!CommonFunctions().isWatkTime(maghrib, state.selectDate)) {
                                            CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                          } else {
                                            _pryerbloc.add(PrayerButtonEvent("m"));
                                          }
                                        },
                                      )),
                                      Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                      Expanded(
                                          child: SalatTrakerAndWakt(
                                        waqtNmae: "isha".tr(),
                                        time: isha,
                                        check: state.rakat[4],
                                        waktImage: ishaW,
                                        function: () {
                                          if (!CommonFunctions().isWatkTime(isha, state.selectDate)) {
                                            CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                          } else {
                                            _pryerbloc.add(PrayerButtonEvent("e"));
                                          }
                                        },
                                      )),
                                      // Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, color: kColorBlackLight),
                                      // Expanded(
                                      //     child: SalatTrakerAndWakt(
                                      //   waqtNmae: "Tahajjud",
                                      //   time: "3.47 AM",
                                      //   check: state.rakat[5],
                                      //   function: () {
                                      //     _pryerbloc.add(PrayerButtonEvent("t"));
                                      //   },
                                      // )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (state is DisableButtonsState) {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Card(
                              color: kColorWhite,
                              surfaceTintColor: kColorWhite,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                        child: SalatTrakerAndWakt(
                                      waktImage: fajr,
                                      waqtNmae: "fajar".tr(),
                                      time: fajar,
                                      check: false,
                                      isDisabled: true,
                                      function: () {
                                        CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                      },
                                    )),
                                    Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                    Expanded(
                                        child: SalatTrakerAndWakt(
                                      waktImage: duhr,
                                      waqtNmae: "duhur".tr(),
                                      time: duhur,
                                      check: false,
                                      isDisabled: true,
                                      function: () {
                                        CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                      },
                                    )),
                                    Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                    Expanded(
                                        child: SalatTrakerAndWakt(
                                      waktImage: asrW,
                                      waqtNmae: "asr".tr(),
                                      time: asr,
                                      check: false,
                                      isDisabled: true,
                                      function: () {
                                        CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                      },
                                    )),
                                    Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                    Expanded(
                                        child: SalatTrakerAndWakt(
                                      waktImage: magrib,
                                      waqtNmae: "maghrib".tr(),
                                      time: maghrib,
                                      check: false,
                                      isDisabled: true,
                                      function: () {
                                        CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                      },
                                    )),
                                    Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
                                    Expanded(
                                        child: SalatTrakerAndWakt(
                                      waqtNmae: "isha".tr(),
                                      time: isha,
                                      check: false,
                                      waktImage: ishaW,
                                      isDisabled: true,
                                      function: () {
                                        CommonFunctions().ShowMessage(context, ContentType.help, "its_not_time".tr(), "please_keep_track_by_praying_on_time".tr());
                                      },
                                    )),
                                    // Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, color: kColorBlackLight),
                                    // Expanded(
                                    //     child: SalatTrakerAndWakt(
                                    //   waqtNmae: "Tahajjud",
                                    //   time: "3.47 AM",
                                    //   check: state.rakat[5],
                                    //   function: () {
                                    //     _pryerbloc.add(PrayerButtonEvent("t"));
                                    //   },
                                    // )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const DefaultCircularProgressIndicator();
                      }
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 45.h,
                    child: const PrayerPagesButtons(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )
            : const TurnOnLocationWidget(),
      ),
    );
  }
}
