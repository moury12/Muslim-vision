// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:muslim_vision/blocs/prayer_screen%20bloc/bloc/prayer_screen_bloc.dart';
// import 'package:muslim_vision/controllers/services/common_strings.dart';
// import 'package:muslim_vision/global_variable.dart';
// import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
// import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
// import 'package:scrollable_clean_calendar/models/day_values_model.dart';
// import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
// import 'package:scrollable_clean_calendar/utils/enums.dart';
// import 'package:scrollable_clean_calendar/utils/extensions.dart';

// // Map<String, Map<String, bool>> salatTrack = {};

// class SalatTrack extends StatefulWidget {
//   final Map<dynamic, Map<dynamic, dynamic>> salatTrack;
//   final DateTime selectDate;
//   final Function fnc;
//   const SalatTrack(this.salatTrack, this.selectDate, this.fnc, {super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _SalatTrackState();
//   }
// }

// class _SalatTrackState extends State<SalatTrack> {
//   // late DateTime selectDate;
//   DateTime getLastDayOfMonth(int year, int month) {
//     return DateTime.utc(year, month + 1, 0);
//   }

//   CleanCalendarController get calendarController => CleanCalendarController(
//         minDate: widget.salatTrack.isNotEmpty ? DateTime.parse(widget.salatTrack.keys.toList()[0]) : DateTime(dtNow.year, dtNow.month, 1),
//         maxDate: getLastDayOfMonth(dtNow.year, dtNow.month),
//         weekdayStart: DateTime.monday,
//         onDayTapped: (date) {
//           widget.fnc(date);
//         },
//         readOnly: false,
//         initialFocusDate: dtNow,
//       );

//   ScrollController scrollController = ScrollController();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   SchedulerBinding.instance.addPostFrameCallback((_) {
//   //     scrollController.jumpTo(DateTime.now().day * 4);
//   //   });
//   //   // selectDate = dtNow;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Flexible(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                   width: deviceWidth.w,
//                   child: SvgPicture.asset(
//                     prayerScreenBanner,
//                     width: deviceWidth.w,
//                     fit: BoxFit.fill,
//                     height: 290.h,
//                   )),
//               ScrollableCleanCalendar(
//                 locale: 'bn',
//                 monthTextStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: kColorWhite),
//                 weekdayTextStyle: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 14.sp, color: kColorWhite, fontWeight: FontWeight.bold),
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 spaceBetweenCalendars: 0.0,
//                 // scrollController: scrollController,
//                 calendarMainAxisSpacing: 0.0,
//                 spaceBetweenMonthAndCalendar: 0,
//                 calendarController: calendarController,
//                 layout: Layout.BEAUTY,
//                 calendarCrossAxisSpacing: 12.h,

//                 dayBuilder: (context, values) {
//                   return dayBuilderWidget(values);
//                 },
//               ),
//             ],
//           ),
//         ),
//         // //track switch
//         // Flexible(
//         //   flex: 4,
//         //   child: Container(
//         //     color: Colors.grey.shade300,
//         //     padding: const EdgeInsets.symmetric(horizontal: 8),
//         //     child: Column(
//         //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //       children: [
//         //         salatSwitch(
//         //           'Fozor',
//         //           salatTrack[selectDate.toString()]?['f'] ?? false,
//         //           (v) {
//         //             if (salatTrack[selectDate.toString()] == null) {
//         //               salatTrack[selectDate.toString()] = {'f': false};
//         //             }
//         //             salatTrack[selectDate.toString()]!['f'] = v;
//         //             setState(() {});
//         //           },
//         //         ),
//         //         salatSwitch(
//         //           'Johor',
//         //           salatTrack[selectDate.toString()]?['j'] ?? false,
//         //           (v) {
//         //             if (salatTrack[selectDate.toString()] == null) {
//         //               salatTrack[selectDate.toString()] = {'j': false};
//         //             }
//         //             salatTrack[selectDate.toString()]!['j'] = v;
//         //             setState(() {});
//         //           },
//         //         ),
//         //         salatSwitch(
//         //           'Asor',
//         //           salatTrack[selectDate.toString()]?['a'] ?? false,
//         //           (v) {
//         //             if (salatTrack[selectDate.toString()] == null) {
//         //               salatTrack[selectDate.toString()] = {'a': false};
//         //             }
//         //             salatTrack[selectDate.toString()]!['a'] = v;
//         //             setState(() {});
//         //           },
//         //         ),
//         //         salatSwitch(
//         //           'Magrib',
//         //           salatTrack[selectDate.toString()]?['m'] ?? false,
//         //           (v) {
//         //             if (salatTrack[selectDate.toString()] == null) {
//         //               salatTrack[selectDate.toString()] = {'m': false};
//         //             }
//         //             salatTrack[selectDate.toString()]!['m'] = v;
//         //             setState(() {});
//         //           },
//         //         ),
//         //         salatSwitch(
//         //           'Esha',
//         //           salatTrack[selectDate.toString()]?['e'] ?? false,
//         //           (v) {
//         //             if (salatTrack[selectDate.toString()] == null) {
//         //               salatTrack[selectDate.toString()] = {'e': false};
//         //             }
//         //             salatTrack[selectDate.toString()]!['e'] = v;
//         //             setState(() {});
//         //           },
//         //         ),
//         //         Align(
//         //           alignment: Alignment.topRight,
//         //           child: CircleAvatar(
//         //             backgroundColor: Colors.blue,
//         //             child: IconButton(
//         //               onPressed: () {
//         //                 // calendarController.clearSelectedDates();
//         //                 // calendarController.jumpToMonth(date: dtNow);
//         //               },
//         //               icon: const Icon(Icons.arrow_upward_rounded),
//         //             ),
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }

//   //############################## Widget Function #######################

//   bool _isAllOktoDoneByDate(DateTime dt) {
//     if ((widget.salatTrack[dt.toString()]?['f'] ?? false) &&
//         (widget.salatTrack[dt.toString()]?['j'] ?? false) &&
//         (widget.salatTrack[dt.toString()]?['a'] ?? false) &&
//         (widget.salatTrack[dt.toString()]?['m'] ?? false) &&
//         (widget.salatTrack[dt.toString()]?['e'] ?? false)) {
//       return true;
//     }
//     return false;
//   }

//   Widget dayBuilderWidget(DayValues values) {
//     final bool isInRange = values.day.isAfter(values.minDate.subtract(const Duration(days: 1))) && values.day.isBefore(values.maxDate.add(const Duration(days: 1)));
//     final bool isToday = values.day.isSameDay(dtNow);
//     final bool isSelectday = values.day.isSameDay(widget.selectDate);

//     //5 okto done or not
//     bool isAllOktoDone = _isAllOktoDoneByDate(values.day);

//     bool isSingleStrick = _isAllOktoDoneByDate(values.day) && !_isAllOktoDoneByDate(values.day.subtract(const Duration(days: 1))) && !_isAllOktoDoneByDate(values.day.add(const Duration(days: 1)));
//     bool isInStrick =
//         _isAllOktoDoneByDate(values.day) && _isAllOktoDoneByDate(values.day.subtract(const Duration(days: 1))) && _isAllOktoDoneByDate(values.day.add(const Duration(days: 1))); // && !values.day.add(const Duration(days: 1)).isSameDay(dtNow);

//     bool isFirstStrick = !_isAllOktoDoneByDate(values.day.subtract(const Duration(days: 1))) && _isAllOktoDoneByDate(values.day);
//     bool isLastStrick = _isAllOktoDoneByDate(values.day) && !_isAllOktoDoneByDate(values.day.add(const Duration(days: 1)));

//     //count okto of date
//     int i = 0;
//     if (widget.salatTrack[values.day.toString()] != null) {
//       widget.salatTrack[values.day.toString()]?['f'] ?? false == true ? i++ : null;
//       widget.salatTrack[values.day.toString()]?['j'] ?? false == true ? i++ : null;
//       widget.salatTrack[values.day.toString()]?['a'] ?? false == true ? i++ : null;
//       widget.salatTrack[values.day.toString()]?['m'] ?? false == true ? i++ : null;
//       widget.salatTrack[values.day.toString()]?['e'] ?? false == true ? i++ : null;
//     }

//     //set color current date
//     late Color todayIndexColor;
//     //set old date color
//     late Color otherDateIndexColor;
//     //

//     if (i == 0) {
//       todayIndexColor = Colors.white;
//       otherDateIndexColor = Colors.white;
//     } else if (i == 1) {
//       todayIndexColor = Colors.orange.shade50;
//       otherDateIndexColor = Colors.orange.shade50;
//     } else if (i == 2) {
//       todayIndexColor = Colors.orange.shade100;
//       otherDateIndexColor = Colors.orange.shade100;
//     } else if (i == 3) {
//       todayIndexColor = Colors.orange.shade200;
//       otherDateIndexColor = Colors.orange.shade200;
//     } else if (i == 4) {
//       todayIndexColor = Colors.orange.shade300;
//       otherDateIndexColor = Colors.orange.shade300;
//     } else if (i == 5) {
//       todayIndexColor = Colors.teal;
//       otherDateIndexColor = Colors.orange.shade400;
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 5.sp),
//       margin: isToday && !isAllOktoDone
//           ? EdgeInsets.all(5.sp)
//           : isToday && isAllOktoDone
//               ? EdgeInsets.all(3.sp)
//               : !isAllOktoDone || isSingleStrick
//                   ? EdgeInsets.all(4.sp)
//                   : EdgeInsets.symmetric(vertical: 4.sp),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: isToday
//             ? todayIndexColor
//             : isFirstStrick || isLastStrick
//                 ? Colors.green
//                 : isInStrick
//                     ? Colors.green.shade500
//                     : otherDateIndexColor,
//         borderRadius: isToday
//             ? BorderRadius.circular(26)
//             : !isAllOktoDone || isSingleStrick
//                 ? BorderRadius.circular(4)
//                 : isFirstStrick
//                     ? const BorderRadius.horizontal(left: Radius.circular(6))
//                     : isLastStrick
//                         ? const BorderRadius.horizontal(right: Radius.circular(6))
//                         : null,
//         border: isToday && isSelectday
//             ? Border.all(width: 2, color: Colors.amber.shade900)
//             : isToday
//                 ? Border.all(width: 1, color: Colors.black)
//                 : isSelectday
//                     ? Border.all(width: 2, color: Colors.amber.shade900)
//                     : null,
//       ),
//       child: Text(
//         values.text.toString(),
//         style: isInRange
//             ? TextStyle(
//                 color: isInStrick
//                     ? Colors.white
//                     : isFirstStrick || isLastStrick
//                         ? Colors.white
//                         : Colors.black,
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.none,
//                 fontSize: 12.sp,
//               )
//             : TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, decoration: TextDecoration.lineThrough, fontSize: 12.sp),
//       ),
//     );
//   }

//   // Widget salatSwitch(String title, bool isDone, Function fnc) {
//   //   return SizedBox(
//   //     height: 40,
//   //     child: Row(
//   //       children: [
//   //         Text(
//   //           title,
//   //           style: const TextStyle(
//   //             fontSize: 18,
//   //             fontWeight: FontWeight.bold,
//   //           ),
//   //         ),
//   //         const Spacer(),
//   //         Checkbox(
//   //           value: isDone,
//   //           onChanged: (value) => fnc(value),
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
// }
