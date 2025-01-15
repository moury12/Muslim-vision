import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/wallpapers.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class HomeScreenHadithCard extends StatelessWidget {
  const HomeScreenHadithCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0).r,
      ),
      color: kColorWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: kColorWhiteGrey.withOpacity(0.2),
                  radius: 15.0.r,
                  child: SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: SvgPicture.asset(quran),
                  ),
                ),
                SizedBox(width: 6.w),
                Text('hadith_of_the_day'.tr(), style: kStyleTextW600CB.copyWith(fontSize: 14.sp)),
              ],
            ),
            SizedBox(height: 8.0.h),
            Text(
              Boxes().syncBox.get('hedis_of_the_day'),
              style: kStyleTextW400CB.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 8.0.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute(
                  child: Wallpapers(
                    greetingsTitle: Boxes().syncBox.get('hedis_of_the_day'),
                    greetingsImage: "",
                    greetingsSubtitle: "",
                  ),
                  direction: AxisDirection.left,
                ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kColorWhiteGrey.withOpacity(0.2),
                ),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    share,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'share'.tr(),
                    style: kStyleTextW600CP.copyWith(fontSize: 11.sp),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
