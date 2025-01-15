import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class DhikrCountWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final bool? isBorderSide;
  final EdgeInsetsGeometry? padding;
  final Function() onTap;

  const DhikrCountWidget({super.key, required this.title, this.isBorderSide = true, required this.backgroundColor, required this.textColor, this.borderColor, this.padding, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: 40.0.w,
        height: 40.0.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: isBorderSide == true
              ? Border.all(
                  width: 0.6.w,
                  color: borderColor!,
                )
              : Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            context.locale.toString() == 'en'
                ? title
                :    convertToBanglaNumber(title),
            style: kStyleTextW600CR.copyWith(fontSize: 12.sp, color: textColor),
          ),
        ),
      ),
    );
  }
}

