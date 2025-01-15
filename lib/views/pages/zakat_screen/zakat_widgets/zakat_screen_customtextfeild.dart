// ignore: duplicate_ignore
// ignore: must_be_immutable
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class TextFieldWithTitle extends StatelessWidget {
  String title;
  TextEditingController controller;
  TextFieldWithTitle({Key? key, required this.title, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: RichText(
              text: TextSpan(
                text: title,
                style: kStyleTextW400CG.copyWith(
                    fontSize: 13.sp, overflow: TextOverflow.ellipsis),
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: kStyleTextW400CB.copyWith(
                          color: Colors.red, fontSize: 10.sp)),
                ],
              ),
            )),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 40.h,
            child: TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                hintText: "0",
                hintStyle: kStyleTextW500CG.copyWith(
                    fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5, color: kColorGrey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.5, color: kColorGrey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                fillColor: kColorLightGray,
                filled: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
