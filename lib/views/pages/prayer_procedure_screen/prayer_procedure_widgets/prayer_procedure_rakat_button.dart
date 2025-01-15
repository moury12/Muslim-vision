import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class PrayerProcedureRakatButton extends StatelessWidget {
  final String rakatNumber;
  final Color backgroundColor;
  final Function() onPressed;
  const PrayerProcedureRakatButton({super.key, required this.rakatNumber, required this.backgroundColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        elevation: 0,
      ),
      child: Text(
        rakatNumber.toLowerCase().tr(),
        style: kStyleTextW700CW.copyWith(fontSize: 12.sp),
      ),
    );
  }
}
