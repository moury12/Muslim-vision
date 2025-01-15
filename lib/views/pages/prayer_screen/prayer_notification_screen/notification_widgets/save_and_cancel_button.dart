import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';

class WaqtWiseSetAlarmPageButton extends StatelessWidget {
  const WaqtWiseSetAlarmPageButton({
    super.key,
  });

  // openPermissionDialog(context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text('notification_permission_required'.tr()),
  //       content: Text('enable_notification_permissions'.tr()),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         SizedBox(width: 8.w),
  //         TextButton(
  //           onPressed: () {
  //             openAppSettings();
  //           },
  //           child: const Text('Settings'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                "cancel".tr(),
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
            onPressed: () async {
              final isNotificationDenied = await Permission.notification.isDenied || await Permission.notification.isPermanentlyDenied;
              if (isNotificationDenied) {
                // this is for playstore update issue
                // if a user updates the app, somehow permission gets removed
                // ignore: use_build_context_synchronously
                CommonFunctions().processNotificationPermission(context, false);

                return;
              }
              if (context.mounted) {
                BlocProvider.of<SalahReminderBloc>(context).add(SalahReminderSaveEvent(context: context));
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Text(
                "save_alarm".tr(),
                style: kStyleTextW700CW.copyWith(fontSize: 12.sp),
              ),
            ),
          ),
        )
      ],
    );
  }
}
