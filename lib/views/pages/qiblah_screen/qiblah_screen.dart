import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/turn_on_location_widget.dart';
import 'package:muslim_vision/views/pages/qiblah_screen/qiblah_widgets/qibla_screen_compass.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({Key? key}) : super(key: key);

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> {
  final utilsBox = Boxes().utilsBox;
  double currentLat = 0.0;
  double currentLong = 0.0;
  double meccaLat = 21.422510;
  double meccaLong = 39.826168;
  double distance = 0.0;
  final lat = Boxes().utilsBox.get('lat');
  final long = Boxes().utilsBox.get('long');
  double calculateDistance(currentLat, currentLong, meccaLat, meccaLong) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((meccaLat - currentLat) * p) / 2 + c(currentLat * p) * c(meccaLat * p) * (1 - c((meccaLong - currentLong) * p)) / 2;
    distance = 12742 * asin(sqrt(a));
    return 12742 * asin(sqrt(a));
  }

  @override
  void initState() {
    super.initState();
    if (lat != null && long != null) {
      currentLat = utilsBox.get('lat');
      currentLong = utilsBox.get('long');
      calculateDistance(currentLat, currentLong, meccaLat, meccaLong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('green_marker_shows_qibla_direction'.tr(), true, [], kStyleTextW500CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: lat != null && long != null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 32.h),
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(backgroundIllustration), fit: BoxFit.cover, opacity: 0.05),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 400,
                    child: Compass(),
                  ),
                  /*   Text(
              'Your location of your location from north is',
              style: kStyleTextW400CG.copyWith(fontSize: 11.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: Text(
                '277.36°',
                style: kStyleTextW700CP.copyWith(fontSize: 32.sp),
              ),
            ),*/
                  Text(
                    'your_distance_from_mecca_is'.tr(),
                    style: kStyleTextW400CG.copyWith(fontSize: 14.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text(
                      "${distance.toInt()} km",
                      style: kStyleTextW700CP.copyWith(fontSize: 26.sp),
                    ),
                  ),
                  const Spacer(),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //       fit: FlexFit.tight,
                  //       child: ElevatedButton(
                  //         onPressed: () {},
                  //         child: Text(
                  //           'Compass View',
                  //           style: kStyleTextW700CW.copyWith(fontSize: 10.sp),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 8.w),
                  //     Flexible(
                  //       fit: FlexFit.tight,
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: kColorWhite,
                  //           shape: RoundedRectangleBorder(
                  //             side: BorderSide(color: kColorPrimary, width: 1.w),
                  //             borderRadius: BorderRadius.circular(6.r),
                  //           ),
                  //         ),
                  //         onPressed: () {},
                  //         child: Text(
                  //           'Map View',
                  //           style: kStyleTextW700CP.copyWith(fontSize: 10.sp),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )
          : const TurnOnLocationWidget(),
    );
  }
}
