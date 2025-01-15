import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class PrayerProcedureTypesOfSalah extends StatelessWidget {
  const PrayerProcedureTypesOfSalah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
          fit: FlexFit.tight,
          flex: 6,
          child: Text(''),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            'sunnah1'.tr(),
            textAlign: TextAlign.center,
            style: kStyleTextW500CDY.copyWith(fontSize: 12.sp),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            'farz1'.tr(),
            textAlign: TextAlign.center,
            style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            'sunnah1'.tr(),
            textAlign: TextAlign.center,
            style: kStyleTextW500CDY.copyWith(fontSize: 12.sp),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            'waajib'.tr(),
            textAlign: TextAlign.center,
            style: kStyleTextW500CBlue.copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
 
 
  }
}
