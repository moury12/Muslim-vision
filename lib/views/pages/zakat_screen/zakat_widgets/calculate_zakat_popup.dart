import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class CalculateZakat extends StatelessWidget {
  final String totalZakatAmount;
  final String code;
  const CalculateZakat({super.key, required this.totalZakatAmount, required this.code});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(20).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      content: SizedBox(
        width: deviceWidth.w,
        height: (deviceHeight / 2).h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                SvgPicture.asset(zakat_calculate, width: deviceWidth.w, fit: BoxFit.fill),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, size: 22.w, color: kColorWhite))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: totalZakatAmount != "your_amount_not_allowed_for_zakat".tr()
                  ? Text(
                      "$totalZakatAmount $code",
                      style: kStyleTextW700CP.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      totalZakatAmount,
                      style: kStyleTextW700CP.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: kStyleTextW700CW.copyWith(fontSize: 13.sp),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
