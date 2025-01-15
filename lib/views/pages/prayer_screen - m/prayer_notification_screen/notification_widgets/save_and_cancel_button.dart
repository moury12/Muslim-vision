import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../../../blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';

class WaqtWiseSetAlarmPageButton extends StatelessWidget {
  const WaqtWiseSetAlarmPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorWhite,
              padding: EdgeInsets.symmetric(vertical: 8.h),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Text(
                "Cancel",
                style: kStyleTextW700CP.copyWith(fontSize: 12.sp),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8.h),
            ),
            onPressed: () {
              BlocProvider.of<SalahReminderBloc>(context)
                  .add(SalahReminderSaveEvent(context: context));
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Text(
                "Save Alarm",
                style: kStyleTextW700CW.copyWith(fontSize: 12.sp),
              ),
            ),
          ),
        )
      ],
    );
  }
}
