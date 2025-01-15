import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_screen.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_notification_screen/prayer_notification_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class PrayerPagesButtons extends StatelessWidget {
  const PrayerPagesButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 6,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: const PrayerProcedureScreen(),
                direction: AxisDirection.left,
              ));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            ),
            child: Text(
              "prayer_procedure".tr(),
              style: kStyleTextW700CW.copyWith(fontSize: 12.sp),
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          flex: 6,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
              ),
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute(
                  child: const PrayerNotificationScreen(),
                  direction: AxisDirection.left,
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_on_outlined,
                    size: 18.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "set_alarm".tr(),
                    style: kStyleTextW700CW.copyWith(fontSize: 12.sp),
                  ),
                ],
              )),
        ),
        /*SizedBox(
          width: 5.w,
        ),
        Expanded(
          flex: 8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: SvgPicture.asset(
                  learnIslam,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Prayer Tracker", style: kStyleTextW700CW.copyWith(fontSize: 12.sp)),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: kColorDeepGreen2.withOpacity(0.5)),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.yellow,
                                      size: 15.sp,
                                    ),
                                    Text("36 Days", style: kStyleTextW500CW.copyWith(fontSize: 9.sp))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_right,
                        color: kColorWhite,
                        size: 18.sp,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),*/
      ],
    );
  }
}
