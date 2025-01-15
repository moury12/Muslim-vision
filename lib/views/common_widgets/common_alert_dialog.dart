import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../global_variable.dart';

class CommonAlertDialog extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CommonAlertDialog({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: kColorBackground,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(20).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      content: SizedBox(
        width: deviceWidth.w,
        height: (deviceHeight / 5).h,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: (deviceWidth / 2.75).w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr(),
                        style: kStyleTextW700CP.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: (deviceWidth / 2.75).w,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      child: Text('yes'.tr()),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
