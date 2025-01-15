import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';

import '../themes/light_theme. dart.dart';

class TurnOnLocationWidget extends StatelessWidget {
  const TurnOnLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/json/turn_on_location.json'),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'turn_on_location_for_qibla'.tr(),
                style: kStyleTextW600CB.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'turn_on_location_to_use_the_qibla_compass_feature_so_you_can_perform_your_prayer_in_the_right_direction'.tr(),
                style: kStyleTextW500CBG.copyWith(fontSize: 12.sp),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () async {
                  await CommonFunctions().processLocationPermission(context, false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.h),
                    color: kColorPrimary,
                  ),
                  height: 46.h,
                  child: Center(
                    child: Text(
                      'turn_on_GPS_location'.tr(),
                      style: kStyleTextW600CW.copyWith(fontSize: 14.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
