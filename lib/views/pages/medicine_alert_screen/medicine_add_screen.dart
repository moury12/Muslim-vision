// ignore_for_file: use_build_context_synchronously



import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/medicine_alert_bloc/medicine_alert_bloc.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_manager.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/settings_screen/setting_screen.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_custom_text_field.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/services/Medicine_notification/medicine_notification_model.dart';

class MedicineAddScreen extends StatefulWidget {
  const MedicineAddScreen({super.key});

  @override
  State<MedicineAddScreen> createState() => _MedicineAddScreenState();
}

class _MedicineAddScreenState extends State<MedicineAddScreen> {
  final TextEditingController _medicineName = TextEditingController();
  final TextEditingController _numberOfDays = TextEditingController();
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool forClear = false;
  String dateTimeNew = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  DateTime notificationtime = DateTime.now();
  int _id = 60;
  final utilBox = Boxes().utilsBox;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<MedicineAlertBloc>().add(LoadMedicineEvent());
        //BlocProvider.of<MedicineAlertBloc>(context).add(LoadMedicineEvent());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar("add_medicine".tr(), false, [], kStyleTextW400CW.copyWith(fontSize: 14.sp), context, () {
          Navigator.pop(context);
        }),
        body: Container(
          margin: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "medicine_name".tr(),
                                style: kStyleTextW500CB.copyWith(fontSize: 16.sp),
                              ),
                              TextSpan(text: '*', style: kStyleTextW500CR.copyWith(fontSize: 14.sp)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TasbeehScreenCustomTextField(maxLines: 1, fontSize: 13, controller: _medicineName, hintText: "medicine_name".tr()),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "number_of_days".tr(),
                              style: kStyleTextW500CB.copyWith(fontSize: 16.sp),
                            ),
                            TextSpan(text: '*', style: kStyleTextW500CR.copyWith(fontSize: 14.sp)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TasbeehScreenCustomTextField(textInputFormatter: [
                        LengthLimitingTextInputFormatter(2),
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]?$')),
                      ], fontSize: 13, textInputType: TextInputType.number, controller: _numberOfDays, hintText: "number_of_days".tr()),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "set_alarm_time".tr(),
                                style: kStyleTextW500CB.copyWith(fontSize: 16.sp),
                              ),
                              TextSpan(text: '*', style: kStyleTextW500CR.copyWith(fontSize: 14.sp)),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 100.h,
                        width: MediaQuery.of(context).size.width.w,
                        child: Center(
                            child: CupertinoDatePicker(
                          initialDateTime: notificationtime,
                          mode: CupertinoDatePickerMode.time,
                          // showDayOfWeek: true,
                          minimumDate: DateTime(2024, 1, 1, 0, 0, 0),
                          dateOrder: DatePickerDateOrder.dmy,

                          onDateTimeChanged: (va) {
                            dateTimeNew = DateFormat('yyyy-MM-dd HH:mm:ss').format(va);

                            notificationtime = va;

                            setState(() {});
                          },
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.sp),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "time_to_take_medicine".tr(),
                              style: kStyleTextW500CB.copyWith(fontSize: 16.sp),
                            ),
                            TextSpan(text: '*', style: kStyleTextW500CR.copyWith(fontSize: 14.sp)),
                          ],
                        ),
                      )),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Transform.scale(
                                    scale: 0.9.sp,
                                    child: Checkbox(
                                      value: checkbox1,
                                      onChanged: (value) {
                                        setState(() {
                                          checkbox1 = value!;
                                          if (checkbox1) {
                                            checkbox2 = false; // Unselect the other checkbox
                                          }
                                        });
                                      },
                                      focusColor: kColorPrimary,
                                      activeColor: kColorPrimary,
                                      // Customize the color
                                      checkColor: Colors.white, // Customize the checkmark color
                                    ),
                                  )),
                                  Text(
                                    "before".tr(),
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Transform.scale(
                                    scale: 0.9.sp,
                                    child: Checkbox(
                                      value: checkbox2,
                                      onChanged: (value) {
                                        setState(() {
                                          checkbox2 = value!;
                                          if (checkbox2) {
                                            checkbox1 = false; // Unselect the other checkbox
                                          }
                                        });
                                      },
                                      hoverColor: kColorPrimary,
                                      activeColor: kColorPrimary,
                                      // Customize the color
                                      // Customize the checkmark color
                                    ),
                                  )),
                                  Text(
                                    "after".tr(),
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            print(utilBox.get('notification'));
                            final isNotificationDenied = await Permission.notification.isDenied || await Permission.notification.isPermanentlyDenied;
                            if ((utilBox.get('notification') != "approved") || isNotificationDenied) {
                              showNotificationPermissionDialog(context);

                              // CommonFunctions().ShowMessage(
                              //   context,
                              //   ContentType.warning,
                              //   "turn_on_GPS_location".tr(),
                              //   "turn_on_location_for_qibla".tr(),
                              // );
                              // await CommonFunctions().processLocationPermissionMedicine(context);
                              return;
                            }
                            // if (isNotificationDenied) {
                            //   // this is for playstore update issue
                            //   // if a user updates the app, somehow permission gets removed

                            //   await CommonFunctions().medicineNotificationPermission(context);

                            //   return;
                            // }

                            try {
                              if (_medicineName.text.isNotEmpty && _numberOfDays.text.isNotEmpty && (checkbox1 || checkbox2)) {
                                _id++;
                                List<int> notificationIds = [];

                                for (var i = 0; i < int.parse(_numberOfDays.text); i++) {
                                  DateTime dateTime = DateTime.now().add(Duration(days: i));
                                  int uniqueId = _id + i;
                                  notificationIds.add(uniqueId);

                                  MedicineNotificationManager().setNotification(
                                    id: uniqueId,
                                    name: _medicineName.text,
                                    tekingTime: checkbox1 ? "before_meal".tr() : "after_meal".tr(),
                                    time: DateTime(
                                      dateTime.year,
                                      dateTime.month,
                                      dateTime.day,
                                      notificationtime.hour,
                                      notificationtime.minute,
                                    ),
                                  );

                                  // Initialize the MedicineReminder model
                                  MedicineReminderModel().initialization(
                                    uniqueId,
                                    _medicineName.text,
                                    "taking time",
                                    'note',
                                    DateTime(
                                      dateTime.year,
                                      dateTime.month,
                                      dateTime.day,
                                      notificationtime.hour,
                                      notificationtime.minute,
                                    ),
                                    true,
                                  );

                                  debugPrint(uniqueId.toString());

                                  // Create the new medicine reminder
                                  final newMedicine = MedicineReminder(
                                    id: uniqueId,
                                    medicneName: _medicineName.text,
                                    takeTime: checkbox1 ? "before_meal" : "after_meal",
                                    time: DateTime.parse(dateTimeNew),
                                    note: "note",
                                  );

                                  // Add the new medicine reminder to the Bloc
                                  context.read<MedicineAlertBloc>().add(AddMedicine(medicineReminder: newMedicine));
                                }

                                _medicineName.clear();
                                _numberOfDays.clear();
                                checkbox1 = false;
                                checkbox2 = false;
                                forClear = true;
                                dateTimeNew = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                                notificationtime = DateTime.now();
                                setState(() {});

                                CommonFunctions().ShowMessage(
                                  context,
                                  ContentType.success,
                                  "medicine_added".tr(),
                                  "you_will_notify".tr(),
                                );
                              } else {
                                CommonFunctions().ShowMessage(
                                  context,
                                  ContentType.warning,
                                  "warning".tr(),
                                  "please_provide".tr(),
                                );
                              }
                            } catch (e) {
                              Exception(e.toString());
                            }
                          },
                          child: Text(
                            "save".tr(),
                            style: TextStyle(fontSize: 14.sp),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showNotificationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('notification_permission_required'.tr()),
          content: Text('need_notification_permission_for_medicine_alert'.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: kColorRed, // Button background color
              ),
              child: Text('Cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CustomPageRoute(
                    child: SettingScreen(isMed: true),
                    direction: AxisDirection.left,
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: kColorPrimary, // Button background color
              ),
              child: Text('Settings'.tr()),
            ),
          ],
        );
      },
    );
  }
}
