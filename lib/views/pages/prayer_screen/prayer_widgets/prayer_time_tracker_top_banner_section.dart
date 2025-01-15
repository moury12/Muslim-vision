// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';

import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

Widget prayerScreenCardWidget(
  String string1,
  String string2,
) {
  // PrayerScreenBloc prayerScreenBloc=PrayerScreenBloc();
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.bottomCenter,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 20.sp),
        child: SvgPicture.asset(
          prayerScreenBanner,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      // Positioned(
      //   top: 20.h,
      //   child: SizedBox(
      //     width: deviceWidth.w,
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 8.w),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           Row(
      //             children: [
      //               Icon(
      //                 Icons.watch_later_outlined,
      //                 color: kColorWhite,
      //                 size: 15.sp,
      //               ),
      //               SizedBox(
      //                 width: 4.w,
      //               ),
      //               Text(
      //                 "${DateTime.now().toString().substring(11, 19)} AM",
      //                 style: kStyleTextW600CW.copyWith(fontSize: 11.sp),
      //               )
      //             ],
      //           ),
      //           // CustomTopRightWidget(city: city),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      Positioned(
        bottom: 1.h,
        child: SizedBox(
          width: 362.w,
          height: 70.h,
          child: Card(
            color: kColorWhite,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // string2.isNotEmpty
                  //     ? CircleAvatar(
                  //         radius: 20.r,
                  //         backgroundColor: kColorBackground,
                  //         child: Center(
                  //             child: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: kColorGreen,
                  //           size: 15.w,
                  //         )))
                  //     : const SizedBox.shrink(),
                  string2.isNotEmpty
                      ? FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                string1,
                                style: kStyleTextW700CP.copyWith(fontSize: 12.sp),
                              ),
                              Text(
                                string2,
                                style: kStyleTextW600CB.copyWith(fontSize: 11.sp),
                              )
                            ],
                          ),
                        )
                      : Text(
                          string1,
                          style: kStyleTextW700CP.copyWith(fontSize: 12.sp),
                        ),
                  // string2.isNotEmpty
                  //     ? CircleAvatar(
                  //         radius: 20.sp,
                  //         backgroundColor: kColorBackground,
                  //         child: Center(
                  //             child: Icon(
                  //           Icons.arrow_forward_ios,
                  //           color: kColorGreen,
                  //           size: 15.sp,
                  //         )))
                  //     : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
