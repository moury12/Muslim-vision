// // // ignore_for_file: must_be_immutable

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:hijri/hijri_calendar.dart';
// // import 'package:intl/intl.dart';
// // import 'package:muslim_vision/blocs/prayer_screen%20bloc/bloc/prayer_screen_bloc.dart';
// // import 'package:muslim_vision/controllers/services/common_functions.dart';
// // import 'package:muslim_vision/controllers/services/common_strings.dart';
// // import 'package:muslim_vision/database/boxes.dart';
// // import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
// // import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
// // import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
// // import 'package:muslim_vision/views/common_widgets/custom_top_right_widget.dart';
// // import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/button_row.dart';
// // import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_time_tracker_top_banner_section.dart';
// // import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_tracke_calender.dart';
// // import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/waqt_wise_tracker_section.dart';
// // import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hijri/hijri_calendar.dart';
// import 'package:muslim_vision/blocs/prayer_screen%20bloc/bloc/prayer_screen_bloc.dart';
// import 'package:muslim_vision/controllers/services/common_functions.dart';
// import 'package:muslim_vision/controllers/services/common_strings.dart';
// import 'package:muslim_vision/database/boxes.dart';
// import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
// import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
// import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
// import 'package:muslim_vision/views/common_widgets/custom_top_right_widget.dart';
// import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/button_row.dart';
// import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_time_tracker_top_banner_section.dart';
// import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_tracke_calender.dart';
// import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/waqt_wise_tracker_section.dart';
// import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

// // class PrayerScreen extends StatefulWidget {
// //   const PrayerScreen({super.key});

// //   @override
// //   State<PrayerScreen> createState() => _PrayerScreenState();
// // }

// // class _PrayerScreenState extends State<PrayerScreen> {
// //   final PrayerScreenBloc _pryerbloc = PrayerScreenBloc();

// //   bool _calendarShow = false;

// //   final utilsBox = Boxes().utilsBox;
// //   String fajar = '';
// //   String duhur = '';
// //   String asr = '';
// //   String maghrib = '';
// //   String isha = '';

// //   _fiveOktoNamazTime() {
// //     final lat = utilsBox.get('lat');
// //     final long = utilsBox.get('long');
// //     DateTime dateTime = DateTime.now();
// //     final prayerTimes = CommonFunctions.getPrayerTime(lat, long, dateTime);
// //     fajar = DateFormat('h:mm a').format(prayerTimes.fajr);
// //     duhur = DateFormat('h:mm a').format(prayerTimes.dhuhr);
// //     asr = DateFormat('h:mm a').format(prayerTimes.asr);
// //     maghrib = DateFormat('h:mm a').format(prayerTimes.maghrib);
// //     isha = DateFormat('h:mm a').format(prayerTimes.isha);
// //   }

// //   @override
// //   void initState() {
  
// //     super.initState();
// //     _fiveOktoNamazTime();
// //     _pryerbloc.add(PrayerCityLoadingEvent());
// //     _pryerbloc.add(PrayerCalendarButtonLoadingEvent());
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     String todayDateHijri = HijriCalendar.now().toFormat('dd MMMM yyyy');
// //     return SafeArea(
// //       child: Column(
// //         children: [
// //           customAppBar(
// //               "Prayer",
// //               false,
// //               [
// //                 BlocBuilder(
// //                   bloc: _pryerbloc,
// //                   buildWhen: (previous, current) => current is PrayerLoadingState || current is PrayerCityLoadedState,
// //                   builder: (context, state) {
// //                     // if (state is PrayerScreenInitial || state is PrayerLoadingState) {
// //                     //   return const Center(child: DefaultCircularProgressIndicator());
// //                     // }
// //                     if (state is PrayerCityLoadedState) {
// //                       return CustomTopRightWidget(city: state.city);
// //                     } else {
// //                       return const Text('err');
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(
// //                   width: 10.w,
// //                 ),
// //                 InkWell(
// //                   highlightColor: Colors.transparent,
// //                   splashColor: Colors.transparent,
// //                   onTap: () {
// //                     _calendarShow = !_calendarShow;
// //                     _pryerbloc.add(PrayerCityCalendarToggleEvent());
// //                   },
// //                   child: SvgPicture.asset(
// //                     calendar,
// //                     height: 24.h,
// //                     width: 24.w,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 10.w,
// //                 )
// //               ],
// //             kStyleTextW700CW.copyWith(fontSize: 16.sp),
// //               context,
// //                (){
// //                  Navigator.pushAndRemoveUntil(
// //                 context,
                
// //                 CustomPageRoute(
// //                   child:  BottomNavBar(index: 0,),
// //                   direction: AxisDirection.left,
// //                 ),
// //                 (route) => false);
// //               }),
// //           SizedBox(
// //             height: 250.h,
// //             child: BlocBuilder(
// //               bloc: _pryerbloc,
// //               buildWhen: (previous, current) => current is PrayerLoadingState || current is PrayerCalendarState,
// //               builder: (context, state) {
// //                 if (state is PrayerScreenInitial || state is PrayerLoadingState) {
// //                   return const Center(child: DefaultCircularProgressIndicator());
// //                 } else if (state is PrayerCalendarState) {
// //                   return _calendarShow
// //                       ? SalatTrack(state.salatTrack, state.selectDate, (v) {
// //                           _pryerbloc.add(PrayerDateClickEvent(v));
// //                         })
// //                       : prayerScreenCardWidget(
// //                           "${DateFormat('MMMM').format(DateTime.now())},${DateTime.now().day},${DateFormat('EEEE').format(DateTime.now())}",
// //                           todayDateHijri,
// //                         );
// //                 } else {
// //                   return const Text('err');
// //                 }
// //               },
// //             ),
// //           ),
// //           BlocBuilder(
// //             bloc: _pryerbloc,
// //             buildWhen: (previous, current) => current is PrayerButtonsState,
// //             builder: (context, state) {
// //               if (state is PrayerButtonsState) {
// //                 return Expanded(
// //                   child: Container(
// //                     margin: EdgeInsets.symmetric(horizontal: 10.w),
// //                     child: Card(
// //                       elevation: 0,
// //                       child: Padding(
// //                         padding: EdgeInsets.all(8.0.r),
// //                         child: Column(
// //                           children: <Widget>[
// //                             Expanded(
// //                                 child: SalatTrakerAndWakt(
// //                               waqtNmae: "Fajar",
// //                               time: fajar,
// //                               check: state.rakat[0],
// //                               function: () {
// //                                 _pryerbloc.add(PrayerButtonEvent("f"));
// //                               },
// //                             )),
// //                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
// //                             Expanded(
// //                                 child: SalatTrakerAndWakt(
// //                               waqtNmae: "Duhur",
// //                               time: duhur,
// //                               check: state.rakat[1],
// //                               function: () {
// //                                 _pryerbloc.add(PrayerButtonEvent("j"));
// //                               },
// //                             )),
// //                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
// //                             Expanded(
// //                                 child: SalatTrakerAndWakt(
// //                               waqtNmae: "Asr",
// //                               time: asr,
// //                               check: state.rakat[2],
// //                               function: () {
// //                                 _pryerbloc.add(PrayerButtonEvent("a"));
// //                               },
// //                             )),
// //                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
// //                             Expanded(
// //                                 child: SalatTrakerAndWakt(
// //                               waqtNmae: "Maghrib",
// //                               time: maghrib,
// //                               check: state.rakat[3],
// //                               function: () {
// //                                 _pryerbloc.add(PrayerButtonEvent("m"));
// //                               },
// //                             )),
// //                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
// //                             Expanded(
// //                                 child: SalatTrakerAndWakt(
// //                               waqtNmae: "Isha",
// //                               time: isha,
// //                               check: state.rakat[4],
// //                               function: () {
// //                                 _pryerbloc.add(PrayerButtonEvent("e"));
// //                               },
// //                             )),
// //                             // Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, color: kColorBlackLight),
// //                             // Expanded(
// //                             //     child: SalatTrakerAndWakt(
// //                             //   waqtNmae: "Tahajjud",
// //                             //   time: "3.47 AM",
// //                             //   check: state.rakat[5],
// //                             //   function: () {
// //                             //     _pryerbloc.add(PrayerButtonEvent("t"));
// //                             //   },
// //                             // )),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               } else {
// //                 return const Text("err");
// //               }
// //             },
// //           ),
// //           SizedBox(
// //             height: 15.h,
// //           ),
// //           Container(
// //             padding: EdgeInsets.symmetric(horizontal: 12.w),
// //             height: 50.h,
// //             child: const PrayerPagesButtons(),
// //           ),
// //           SizedBox(
// //             height: 20.h,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//   @override
//   void initState() {
//     super.initState();
//     _fiveOktoNamazTime();
//     _pryerbloc.add(PrayerCityLoadingEvent());
//     _pryerbloc.add(PrayerCalendarButtonLoadingEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     String todayDateHijri = HijriCalendar.now().toFormat('dd MMMM yyyy');
//     return SafeArea(
//       child: Column(
//         children: [
//           customAppBar(
//               "prayer".tr(),
//               false,
//               [
//                 BlocBuilder(
//                   bloc: _pryerbloc,
//                   buildWhen: (previous, current) => current is PrayerLoadingState || current is PrayerCityLoadedState,
//                   builder: (context, state) {
//                     // if (state is PrayerScreenInitial || state is PrayerLoadingState) {
//                     //   return const Center(child: DefaultCircularProgressIndicator());
//                     // }
//                     if (state is PrayerCityLoadedState) {
//                       return CustomTopRightWidget(city: state.city);
//                     } else {
//                       return const Text('err');
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: () {
//                     _calendarShow = !_calendarShow;
//                     _pryerbloc.add(PrayerCityCalendarToggleEvent());
//                   },
//                   child: SvgPicture.asset(
//                     calendar,
//                     height: 24.h,
//                     width: 24.w,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 )
//               ],
//               kStyleTextW700CW.copyWith(fontSize: 16.sp),
//               context, () {
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 CustomPageRoute(
//                   child: BottomNavBar(
//                     index: 0,
//                   ),
//                   direction: AxisDirection.left,
//                 ),
//                 (route) => false);
//           }),
//           SizedBox(
//             height: 250.h,
//             child: BlocBuilder(
//               bloc: _pryerbloc,
//               buildWhen: (previous, current) => current is PrayerLoadingState || current is PrayerCalendarState,
//               builder: (context, state) {
//                 if (state is PrayerScreenInitial || state is PrayerLoadingState) {
//                   return const Center(child: DefaultCircularProgressIndicator());
//                 } else if (state is PrayerCalendarState) {
//                   return _calendarShow
//                       ? SalatTrack(state.salatTrack, state.selectDate, (v) {
//                           _pryerbloc.add(PrayerDateClickEvent(v));
//                         })
//                       : prayerScreenCardWidget(
//                           "${DateFormat('MMMM').format(DateTime.now())},${DateTime.now().day},${DateFormat('EEEE').format(DateTime.now())}",
//                           todayDateHijri,
//                         );
//                 } else {
//                   return const Text('err');
//                 }
//               },
//             ),
//           ),
//           BlocBuilder(
//             bloc: _pryerbloc,
//             buildWhen: (previous, current) => current is PrayerButtonsState,
//             builder: (context, state) {
//               if (state is PrayerButtonsState) {
//                 return Expanded(
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10.w),
//                     child: Card(
//                       elevation: 0,
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0.r),
//                         child: Column(
//                           children: <Widget>[
//                             Expanded(
//                                 child: SalatTrakerAndWakt(
//                               waqtNmae: "fajar".tr(),
//                               time: fajar,
//                               check: state.rakat[0],
//                               function: () {
//                                 _pryerbloc.add(PrayerButtonEvent("f"));
//                               },
//                             )),
//                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
//                             Expanded(
//                                 child: SalatTrakerAndWakt(
//                               waqtNmae: "duhur".tr(),
//                               time: duhur,
//                               check: state.rakat[1],
//                               function: () {
//                                 _pryerbloc.add(PrayerButtonEvent("j"));
//                               },
//                             )),
//                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
//                             Expanded(
//                                 child: SalatTrakerAndWakt(
//                               waqtNmae: "asr".tr(),
//                               time: asr,
//                               check: state.rakat[2],
//                               function: () {
//                                 _pryerbloc.add(PrayerButtonEvent("a"));
//                               },
//                             )),
//                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
//                             Expanded(
//                                 child: SalatTrakerAndWakt(
//                               waqtNmae: "maghrib".tr(),
//                               time: maghrib,
//                               check: state.rakat[3],
//                               function: () {
//                                 _pryerbloc.add(PrayerButtonEvent("m"));
//                               },
//                             )),
//                             Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w),
//                             Expanded(
//                                 child: SalatTrakerAndWakt(
//                               waqtNmae: "isha".tr(),
//                               time: isha,
//                               check: state.rakat[4],
//                               function: () {
//                                 _pryerbloc.add(PrayerButtonEvent("e"));
//                               },
//                             )),
//                             // Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, color: kColorBlackLight),
//                             // Expanded(
//                             //     child: SalatTrakerAndWakt(
//                             //   waqtNmae: "Tahajjud",
//                             //   time: "3.47 AM",
//                             //   check: state.rakat[5],
//                             //   function: () {
//                             //     _pryerbloc.add(PrayerButtonEvent("t"));
//                             //   },
//                             // )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 return const Text("err");
//               }
//             },
//           ),
//           SizedBox(
//             height: 15.h,
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w),
//             height: 50.h,
//             child: const PrayerPagesButtons(),
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//         ],
//       ),
//     );
//   }
// }
