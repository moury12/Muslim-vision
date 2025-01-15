// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../../../blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';
import '../../../../../models/salah_reminder_model.dart';

class PrayerTimeAlarmSetupWidget extends StatelessWidget {
  String waqtName;
  bool? isSwitchOn;
  int id;
  Map<int, SalahReminderModel> salahReminderMap;
  PrayerTimeAlarmSetupWidget({
    Key? key,
    required this.waqtName,
    required this.isSwitchOn,
    required this.id,
    required this.salahReminderMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle_outlined,
                color: kColorGrey.withOpacity(0.5),
                size: 18.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                waqtName,
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
                    onChanged: (value) {
                      salahReminderMap[id]?.isEnabled = value;
                      BlocProvider.of<SalahReminderBloc>(context).add(
                          SalahReminderEditEvent(
                              salahReminderMap: salahReminderMap));
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
