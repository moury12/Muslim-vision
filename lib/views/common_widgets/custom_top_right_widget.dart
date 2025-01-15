import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class CustomTopRightWidget extends StatelessWidget {
  final String? city;
  const CustomTopRightWidget({super.key, this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhiteGrey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 1.h),
        child: Row(
          children: [
            Image.asset(
              world,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(width: 4.w),
            Text(city.toString(), style: kStyleTextW400CW.copyWith(fontSize: 12.sp, color: kColorWhite.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}
