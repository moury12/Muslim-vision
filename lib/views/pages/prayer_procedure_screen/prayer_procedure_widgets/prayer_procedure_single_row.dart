import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_widgets/prayer_procedure_rakat_button.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class PrayerProcedureSingleRow extends StatelessWidget {
  final String waktName;
  final String waktNametitle;
  final String beforeSunnahRakatNumber;
  final Color beforeSunnahColor;
  final String farjRakatNumber;
  final Color farjColor;
  final String afterSunnahRakatNumber;
  final Color afterSunnahColor;
  final String wajibRakatNumber;
  final Color wajibColor;
  final bool isActive;

  const PrayerProcedureSingleRow({
    super.key,
    required this.waktName,
    required this.waktNametitle,
    required this.isActive,
    required this.beforeSunnahRakatNumber,
    required this.beforeSunnahColor,
    required this.farjRakatNumber,
    required this.farjColor,
    required this.afterSunnahRakatNumber,
    required this.afterSunnahColor,
    required this.wajibRakatNumber,
    required this.wajibColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 6,
          child: Row(
            children: [
              isActive
                  ? Container(
                      padding: const EdgeInsets.all(4.0).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                        boxShadow: [
                          BoxShadow(color: kColorPrimary.withOpacity(0.2)),
                        ],
                      ),
                      child: const Icon(Icons.circle_rounded, color: kColorPrimary),
                    )
                  : Container(
                      padding: const EdgeInsets.all(4.0).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                      ),
                      child: Icon(Icons.circle_outlined, color: kColorGrey.withOpacity(0.5)),
                    ),
              SizedBox(width: 8.w),
              Flexible(child: Text(waktNametitle.toLowerCase().tr(), style: kStyleTextW600CB.copyWith(fontSize: 12.sp))),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(border: Border(left: BorderSide(color: kColorGrey, width: 1), right: BorderSide(color: kColorGrey, width: 1))),
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
          child: Container(
            decoration: const BoxDecoration(border: Border(left: BorderSide(color: kColorGrey, width: 1), right: BorderSide(color: kColorGrey, width: 1))),
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
    );
  }
}
