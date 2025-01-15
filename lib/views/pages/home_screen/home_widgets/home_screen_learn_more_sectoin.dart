import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class HomeScreenLearnMoreSection extends StatelessWidget {
  const HomeScreenLearnMoreSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(learnIslam, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0).r,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Learn more about Islam',
                    style: kStyleTextW700CW.copyWith(fontSize: 17.sp),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: kColorWhite,
                    size: 24.0.w,
                  )
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                'Lighten yourself more by gathering more knowledge about Islam and be a better muslim.',
                style: kStyleTextW400CW.copyWith(fontSize: 11.sp),
              )
            ],
          ),
        ),
      ],
    );
  }
}
