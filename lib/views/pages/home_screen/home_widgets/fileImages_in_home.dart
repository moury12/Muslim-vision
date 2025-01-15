// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

// ignore: must_be_immutable
class ShowFileImage extends StatelessWidget {
  String img;
  String webLisk;
  bool flag;

  ShowFileImage({super.key, required this.img, required this.webLisk, required this.flag});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => flag ? CommonFunctions().launchInBrowser(Uri.parse(webLisk)) : "",
      child: Card(
        margin: EdgeInsets.zero,
        color: kColorWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  fit: BoxFit.fill,
                  File('/data/user/0/com.muslim_vision/app_flutter/$img.png'),
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.w),
              child: ElevatedButton(
                onPressed: () async {
                  if (await CommonFunctions().hasInternetConnection()) {
                    await CommonFunctions().shareOnlineImage(File('/data/user/0/com.muslim_vision/app_flutter/$img.png'));
                  } else {
                    CommonFunctions().ShowMessage(context, ContentType.warning, "no_internet_connection".tr(), "please_try_with_internet_connection".tr());
                  }
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
