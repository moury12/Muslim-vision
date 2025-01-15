import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/global_variable.dart';

import '../../controllers/services/common_strings.dart';
import '../themes/light_theme. dart.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

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
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(login, width: deviceWidth.w, fit: BoxFit.fill),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, size: 22.w, color: kColorWhite),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          backgroundColor: kColorFacebook,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.facebook),
                            SizedBox(width: 8.w),
                            Text(
                              'Login with Facebook',
                              style: kStyleTextW700CW.copyWith(fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColorWhite,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          elevation: 2.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.gps_off_outlined),
                            SizedBox(width: 8.w),
                            Text(
                              'Sign in with Google',
                              style: kStyleTextW500CG.copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      flex: 6,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Login Muslim Vision to use all features',
                          style: kStyleTextW400CG.copyWith(fontSize: 11.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
