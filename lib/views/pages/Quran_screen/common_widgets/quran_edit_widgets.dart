import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/components/custom_divider.dart';
import 'package:muslim_vision/constants/sizedbox_constant.dart';
import 'package:muslim_vision/constants/textstyle_constants.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'dart:ui' as ui;

class QuranThemeContainerWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  const QuranThemeContainerWidget({
    super.key,
    this.title,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(6.sp),
      margin: EdgeInsets.symmetric(vertical: 6.sp),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.wb_sunny_outlined,
            color: textColor ?? kColorBlack,
            size: 15.sp,
          ),
          space6W,
          Text(
            title ?? 'Light',
            style: text14W600White.copyWith(
              color: textColor ?? kColorBlack,
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class QuranEditDialog extends StatelessWidget {
  double progressValue;
  final Function()? lightThemeTap;
  final Function()? darkThemeTap;
  final Function(double) onChange;
  QuranEditDialog({super.key, required this.progressValue, required this.onChange, this.lightThemeTap, this.darkThemeTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12 + kToolbarHeight),
      child: Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Material(
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(color: kColorGreen2.withOpacity(.5)),
                // color: Color(0xffFFF4F2),

                width: MediaQuery.of(context).size.width - 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Text size', style: text14White),
                    SizedBox(
                      height: 10.h,
                    ),
                    SliderTheme(
                      data: const SliderThemeData(
                        trackHeight: 4,
                        overlayColor: kColorPrimary,
                        thumbColor: kColorPrimary,
                        activeTrackColor: kColorPrimary,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                      ),
                      child: Slider(
                        value: progressValue,
                        min: 0.0,
                        max: 1.0,
                        onChanged: onChange,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('A', style: text10White),
                        Text('A', style: text16White),
                      ],
                    ),
                    const MvDivider(),
                    Text('Appearance', style: text14White),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(onTap: lightThemeTap, child: const QuranThemeContainerWidget()),
                        ),
                        space6W,
                        Expanded(
                          child: GestureDetector(
                            onTap: darkThemeTap,
                            child: const QuranThemeContainerWidget(
                              backgroundColor: kColorBlack,
                              textColor: kColorWhite,
                              icon: CupertinoIcons.moon,
                              title: 'Dark',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

ThemeData lightQuranTheme = ThemeData(
    primaryColor: kColorPrimary,
    scaffoldBackgroundColor: kColorWhite,
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(iconColor: Colors.white),
      textStyle: TextStyle(
        color: Colors.black, // Text color
        fontSize: 16,
      ),
    ),
    appBarTheme: const AppBarTheme(shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent, backgroundColor: kColorPrimary, foregroundColor: kColorWhite));
ThemeData darkQuranTheme = ThemeData.dark().copyWith(
    primaryColor: kColorDeepGreen,
    scaffoldBackgroundColor: kColorDeepGreen,
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(iconColor: Colors.white38),
      textStyle: TextStyle(
        color: Colors.black, // Text color
        fontSize: 16,
      ),
    ),
    appBarTheme: const AppBarTheme(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: kColorDeepGreen,
        foregroundColor: kColorSwitchInactiveGrey)) /*(
    primaryColor: kColorPrimary, scaffoldBackgroundColor: kColorBlackLight,

    textTheme: TextTheme(
  bodySmall: TextStyle(color:Colors.white)

)*/ /*)*/;
