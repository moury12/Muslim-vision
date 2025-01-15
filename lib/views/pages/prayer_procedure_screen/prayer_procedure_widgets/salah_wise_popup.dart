import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_widgets/prayer_procedure_rakat_button.dart';

import '../../../themes/light_theme. dart.dart';

// ignore: must_be_immutable
class SalahWisePopup extends StatelessWidget {
  BuildContext context;
  String waktName;
  String waktNametitle;
  String prayerTime;
  String totalRakat;
  String sunnah;
  String farjRakatNumber;
  String beforeSunnahRakatNumber;
  String afterSunnahRakatNumber;
  String wajibRakatNumber;
  Color beforeSunnahColor;
  Color farjColor;
  Color afterSunnahColor;
  Color wajibColor;

  SalahWisePopup({
    required this.context,
    required this.waktName,
    required this.waktNametitle,
    required this.prayerTime,
    required this.totalRakat,
    required this.farjRakatNumber,
    required this.sunnah,
    required this.afterSunnahColor,
    required this.afterSunnahRakatNumber,
    required this.beforeSunnahColor,
    required this.beforeSunnahRakatNumber,
    required this.farjColor,
    required this.wajibColor,
    required this.wajibRakatNumber,
    super.key,
  });

  @override
  Widget build(context) {
    String locale = Localizations.localeOf(context).languageCode;
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, d MMM, yyyy', locale).format(now);
    // var formatter = DateFormat('EEEE, d MMM, yyyy');
    // String formattedDate = formatter.format(now);
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,

      actionsPadding: EdgeInsets.zero,

      backgroundColor: kColorWhite,
      // title: Center(child: Text(waktName,style: kStyleTextW600CP,)),
      title: SizedBox(
        //decoration: BoxDecoration(
        //border: Border.all(color: Color(0xfffdacfa2), width: 2),
        //borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        //color: Color(0xffffff3c9),
        // ),
        height: 100.h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                child: SvgPicture.asset(
                  salah_timerpopup,
                  width: deviceWidth.w,
                  //height: 90.h,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${waktNametitle.toLowerCase().tr()}- ${"salah_time".tr()}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          child: const Icon(Icons.clear, color: Colors.white))
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: Text(
                      formatter,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      content: SizedBox(
        height: deviceHeight * 0.17.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat('h:mm a', locale).format(DateTime.parse(prayerTime))),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'total_rakat'.tr(),
                      style: kStyleTextW600CB.copyWith(
                        fontSize: 10.sp,
                      )),
                  TextSpan(text: '${context.locale.toString() == 'en' ? totalRakat : convertToBanglaNumber(totalRakat)}  |  ', style: kStyleTextW600CB.copyWith(fontSize: 10.sp)),
                  TextSpan(
                      text: 'farz'.tr(),
                      style: kStyleTextW600CB.copyWith(
                        fontSize: 10.sp,
                      )),
                  TextSpan(text: '${context.locale.toString() == 'en' ? farjRakatNumber : convertToBanglaNumber(farjRakatNumber)}  |  ', style: kStyleTextW600CB.copyWith(fontSize: 10.sp)),
                  TextSpan(
                      text: 'sunnah'.tr(),
                      style: kStyleTextW600CB.copyWith(
                        fontSize: 10.sp,
                      )),
                  TextSpan(text: context.locale.toString() == 'en' ? sunnah : convertToBanglaNumber(sunnah), style: kStyleTextW600CB.copyWith(fontSize: 10.sp)),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'sunnah1'.tr(),
                    textAlign: TextAlign.center,
                    style: kStyleTextW500CDY.copyWith(fontSize: 12.sp),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'farz1'.tr(),
                    textAlign: TextAlign.center,
                    style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'sunnah1'.tr(),
                    textAlign: TextAlign.center,
                    style: kStyleTextW500CDY.copyWith(fontSize: 12.sp),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'waajib'.tr(),
                    textAlign: TextAlign.center,
                    style: kStyleTextW500CBlue.copyWith(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      const Expanded(child: Text('')),
                      Expanded(
                        flex: 6,
                        child: PrayerProcedureRakatButton(
                          rakatNumber: beforeSunnahRakatNumber,
                          backgroundColor: beforeSunnahColor,
                          onPressed: () {
                            if (beforeSunnahRakatNumber == 'X') {
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              '/salatProcedure',
                              arguments: {
                                'waktName': waktName,
                                'waktNametitle': waktNametitle,
                                'rakatType': 'sunnah',
                                'rakatNumber': beforeSunnahRakatNumber,
                              },
                            );
                          },
                        ),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      const Expanded(child: Text('')),
                      Expanded(
                        flex: 6,
                        child: PrayerProcedureRakatButton(
                          rakatNumber: farjRakatNumber,
                          backgroundColor: farjColor,
                          onPressed: () {
                            if (farjRakatNumber == 'X') {
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              '/salatProcedure',
                              arguments: {
                                'waktName': waktName,
                                'waktNametitle': waktNametitle,
                                'rakatType': 'farj',
                                'rakatNumber': farjRakatNumber,
                              },
                            );
                          },
                        ),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      const Expanded(child: Text('')),
                      Expanded(
                        flex: 6,
                        child: PrayerProcedureRakatButton(
                          rakatNumber: afterSunnahRakatNumber,
                          backgroundColor: afterSunnahColor,
                          onPressed: () {
                            if (afterSunnahRakatNumber == 'X') {
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              '/salatProcedure',
                              arguments: {
                                'waktName': waktName,
                                'waktNametitle': waktNametitle,
                                'rakatType': 'sunnah',
                                'rakatNumber': afterSunnahRakatNumber,
                              },
                            );
                          },
                        ),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      const Expanded(child: Text('')),
                      Expanded(
                        flex: 6,
                        child: PrayerProcedureRakatButton(
                          rakatNumber: wajibRakatNumber,
                          backgroundColor: wajibColor,
                          onPressed: () {
                            if (wajibRakatNumber == 'X') {
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              '/salatProcedure',
                              arguments: {
                                'waktName': waktName,
                                'waktNametitle': waktNametitle,
                                'rakatType': 'wajib',
                                'rakatNumber': wajibRakatNumber,
                              },
                            );
                          },
                        ),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
