import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muslim_vision/blocs/medicine_alert_bloc/medicine_alert_bloc.dart';
import 'package:muslim_vision/controllers/services/Medicine_notification/medicine_notification_model.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/medicine_alert_screen/medicine_add_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class DailyAlartViewScreen extends StatefulWidget {
  const DailyAlartViewScreen({super.key});

  @override
  State<DailyAlartViewScreen> createState() => _DailyAlartViewScreenState();
}

class _DailyAlartViewScreenState extends State<DailyAlartViewScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    BlocProvider.of<MedicineAlertBloc>(context).add(LoadMedicineEvent());
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    final Box box = Boxes().medicineBox;

    // print(Boxes().medicineBox.values.toList()[0]['label']);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kColorPrimary,
          onPressed: () async {
            await Navigator.of(context).push(
              CustomPageRoute(
                child: const MedicineAddScreen(),
                direction: AxisDirection.left,
              ),
            );
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Icon(
                Icons.add_alarm_rounded,
                size: Tween<double>(begin: 22.sp, end: 35.sp)
                    .animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ))
                    .value,
                color: kColorWhite,
              );
            },
          ),
        ),
        appBar: customAppBar(
            "daily_medicine".tr(),
            false,
            [
              BlocBuilder<MedicineAlertBloc, MedicineAlertState>(
                builder: (context, state) {
                  if (state is MedicinesLoadedState) {
                    return state.medicineReminderModel.isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("are_you_sure_to_delete".tr()),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (box.isNotEmpty) {
                                          BlocProvider.of<MedicineAlertBloc>(context).add(DeleteAllMedicine());
                                          BlocProvider.of<MedicineAlertBloc>(context).add(LoadMedicineEvent());
                                        }
                                        CommonFunctions().ShowMessage(context, ContentType.success, "all_medicine_deleted_Successfully".tr(), "your_medicines_are_removed_from_Medicine_alart".tr());
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 0), backgroundColor: Colors.red),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text('yes'.tr()),
                                      )),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('no'.tr()),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 22.sp,
                        ));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              // IconButton(
              //     onPressed: () async {
              //       await Navigator.of(context).push(
              //         CustomPageRoute(
              //           child: const MedicineAddScreen(),
              //           direction: AxisDirection.left,
              //         ),
              //       );
              //     },
              //     icon: Icon(
              //       Icons.add_alarm_rounded,
              //       size: 22.sp,
              //     )),
            ],
            kStyleTextW500CW.copyWith(fontSize: 14.sp),
            context, () {
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute<void>(builder: (BuildContext context) => BottomNavBar(index: 0)), (route) => false);
          Navigator.pushAndRemoveUntil(
              context,
              CustomPageRoute(
                child: BottomNavBar(
                  index: 0,
                ),
                direction: AxisDirection.right,
              ),
                  (route) => false);
        }),
        body: Column(
          children: [
            Expanded(
                child: BlocBuilder<MedicineAlertBloc, MedicineAlertState>(
                  buildWhen: (previous, current) => current is MedicinesLoadedState,
                  builder: (context, state) {
                    if (state is MedicinesLoadedState) {
                      final uniqueMedicineList = <MedicineReminder>{};

                      for (var medicine in state.medicineReminderModel) {
                        final identifier = '${medicine.medicneName}_${medicine.time.hour}:${medicine.time.minute}';
                        if (uniqueMedicineList.every((e) => '${e.medicneName}_${e.time.hour}:${e.time.minute}' != identifier)) {
                          uniqueMedicineList.add(medicine);
                        }
                      }

                      final filteredMedicineList = uniqueMedicineList.toList();

                      if (filteredMedicineList.isEmpty) {
                        return Center(
                          child: Text(
                            "medicine_list_empty".tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(.7),
                              fontSize: 14.sp,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: filteredMedicineList.length,
                          itemBuilder: (context, index) {
                            final medicineList = filteredMedicineList[index];
                            debugPrint(medicineList.id.toString());
                            return Card(
                                color: Colors.white,
                                shadowColor: kColorPrimary,
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: ListTile(
                                  leading: /*Switch(
                                onChanged: (value) {},
                                activeColor: kColorPrimary,
                                value: true,
                              )*/
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Image.asset(
                                      'assets/images/drugs.png',
                                      height: 28.h,
                                    ),
                                  ),
                                  title: RichText(
                                    text: TextSpan(text: '', children: [
                                      TextSpan(text: '${"medicine_name".tr()}:  ', style: TextStyle(fontWeight: FontWeight.w700, color: kColorPrimary, fontSize: 15.sp)),
                                      TextSpan(text: medicineList.medicneName, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black.withOpacity(.7), fontSize: 15.sp))
                                    ]),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.alarm_sharp,
                                              color: kColorPrimary,
                                              size: 18.sp,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(context.locale.toString() == 'en' ? DateFormat('hh:mm a').format(medicineList.time).toString() : convertToBanglaNumber(DateFormat('hh:mm a').format(medicineList.time).toString()),
                                                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black.withOpacity(.7), fontSize: 12.sp))
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.fastfood,
                                              color: kColorPrimary,
                                              size: 18.sp,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(medicineList.takeTime.tr(), style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black.withOpacity(.7), fontSize: 12.sp))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 22.sp,
                                      color: kColorPrimary,
                                    ),
                                    onPressed: () {
                                      // debugPrint(medicineList.id.toString());
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text("are_you_sure_to_delete".tr()),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    context.read<MedicineAlertBloc>().add(DeleteMedicine(medicineName: medicineList.medicneName, time: medicineList.time));
                                                    CommonFunctions().ShowMessage(context, ContentType.success, "deleted_successfully".tr(), "your_medicine_removed_from_Medicine_alart".tr());
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 0), backgroundColor: Colors.red),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text('yes'.tr()),
                                                  )),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text('no'.tr()),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ));
                          });
                    } else {
                      return const Center(child: Text('No data available.'));
                    }
                  },
                ))
          ],
        ));
  }
}
