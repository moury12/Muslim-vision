import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/models/salah_reminder_model.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_notification_screen/notification_widgets/save_and_cancel_button.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_notification_screen/notification_widgets/set_alarms_buttons.dart';
import 'package:muslim_vision/views/pages/prayer_screen/prayer_widgets/prayer_time_tracker_top_banner_section.dart';

import '../../../common_widgets/awesome_snack_bar.dart';

class PrayerNotificationScreen extends StatefulWidget {
  const PrayerNotificationScreen({super.key});

  @override
  State<PrayerNotificationScreen> createState() => _PrayerNotificationScreenState();
}

class _PrayerNotificationScreenState extends State<PrayerNotificationScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SalahReminderBloc>(context).add(SalahReminderLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top,),
          SizedBox(
            height: 220.h,
            child: SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: prayerScreenCardWidget(
                      "set_alarm_for_salah_reminder".tr(),
                      "",
                    ),
                  ),
                  SvgPicture.asset(
                    alarmClock,
                    height: 60.h,
                    width: 60.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              elevation: 0,
              child: BlocConsumer<SalahReminderBloc, SalahReminderState>(
                buildWhen: (previous, current) => current is! SalahReminderActionState,
                listenWhen: (previous, current) => current is SalahReminderActionState,
                listener: (context, state) {
                  if (state is SalahReminderNotificationSuccessState) {
                    final snackBar = aweSomeSnackBar(title: 'success'.tr(), subTitle: state.msg, contentType: ContentType.success, duration: 1100);

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is SalahReminderLoadedState) {
                    return Column(
                      children: <Widget>[
                        PrayerTimeAlarmWidget(
                          img: fajr,
                          salahReminderModel: state.salahReminderMap[1]!,
                          salahReminderMap: state.salahReminderMap,
                        ),
                        Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, height: 0),
                        PrayerTimeAlarmWidget(
                          img: duhr,
                          salahReminderModel: state.salahReminderMap[2]!,
                          salahReminderMap: state.salahReminderMap,
                        ),
                        Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, height: 0),
                        PrayerTimeAlarmWidget(
                          img: asrW,
                          salahReminderModel: state.salahReminderMap[3]!,
                          salahReminderMap: state.salahReminderMap,
                        ),
                        Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, height: 0),
                        PrayerTimeAlarmWidget(
                          img: magrib,
                          salahReminderModel: state.salahReminderMap[4]!,
                          salahReminderMap: state.salahReminderMap,
                        ),
                        Divider(thickness: 0.8, indent: 40.w, endIndent: 15.w, height: 0),
                        PrayerTimeAlarmWidget(
                          img: ishaW,
                          salahReminderModel: state.salahReminderMap[5]!,
                          salahReminderMap: state.salahReminderMap,
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const WaqtWiseSetAlarmPageButton(),
          ),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }
}

class PrayerTimeAlarmWidget extends StatelessWidget {
  final SalahReminderModel salahReminderModel;
  final Map<int, SalahReminderModel> salahReminderMap;
  final String img;

  const PrayerTimeAlarmWidget({super.key, required this.img, required this.salahReminderModel, required this.salahReminderMap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: PrayerTimeAlarmSetupWidget(
        waktImage: img,
        waqtName: salahReminderModel.waqtName,
        isSwitchOn: salahReminderModel.isEnabled,
        id: salahReminderModel.id,
        salahReminderMap: salahReminderMap,
      ),
    );
  }
}
