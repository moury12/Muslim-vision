// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class SalatTrakerAndWakt extends StatelessWidget {
  String waqtNmae;
  String time;
  Function function;
  bool check;
  SalatTrakerAndWakt({
    Key? key,
    required this.waqtNmae,
    required this.time,
    required this.check,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: kColorGrey.withOpacity(0.5),
                size: 18.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                waqtNmae,
                style: kStyleTextW600CB.copyWith(fontSize: 15.sp),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: kStyleTextW600CP.copyWith(fontSize: 11.sp),
              ),
              SizedBox(
                width: 25.w,
              ),
              // Icon(Icons.check_circle,color:kColorPrimary,size: 30.sp,),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => function(),
                child: SvgPicture.asset(
                  check ? tick : nonTick,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
