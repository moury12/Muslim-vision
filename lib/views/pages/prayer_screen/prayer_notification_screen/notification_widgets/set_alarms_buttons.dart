// ignore_for_file: must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../../../blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';
import '../../../../../models/salah_reminder_model.dart';

class PrayerTimeAlarmSetupWidget extends StatelessWidget {
  String waqtName;
  bool? isSwitchOn;
  int id;
  Map<int, SalahReminderModel> salahReminderMap;
  String waktImage;
  PrayerTimeAlarmSetupWidget({Key? key, required this.waqtName, required this.isSwitchOn, required this.id, required this.salahReminderMap, required this.waktImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                waktImage,
                height: 16.h,
                width: 16.w,
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(kColorGreen, BlendMode.srcIn),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                waqtName.toString().toLowerCase().tr(),
                style: kStyleTextW600CB.copyWith(fontSize: 15.sp),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.notifications_on_outlined,
                size: 20.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Transform.scale(
                scale: 0.9,
                child: Switch(
                    activeColor: kColorPrimary,
                    activeTrackColor: kColorGreen,
                    inactiveThumbColor: kColorPrimary,
                    inactiveTrackColor: kColorSwitchInactiveGrey,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    trackOutlineWidth: MaterialStateProperty.all(0),
                    thumbIcon: MaterialStateProperty.all(Icon(
                      Icons.circle,
                      color: kColorGreen.withOpacity(0.3),
                      size: 24.sp,
                    )),
                    value: isSwitchOn!,
                    onChanged: (value) async{
                      bool isAzanOn= await Boxes().utilsBox.get('azan_notification',defaultValue: true);
                      if(!isAzanOn)
                      {
                        CommonFunctions().ShowMessage(
                          context,
                          ContentType.warning,
                          "trun_azan_on".tr(),
                          "trun_azan_on_from_settings".tr(),

                        );
                        return;
                      }
                      salahReminderMap[id]?.isEnabled = value;
                      BlocProvider.of<SalahReminderBloc>(context).add(SalahReminderEditEvent(salahReminderMap: salahReminderMap));}),
              )
            ],
          ),
        ],
      ),
    );
  }
}
