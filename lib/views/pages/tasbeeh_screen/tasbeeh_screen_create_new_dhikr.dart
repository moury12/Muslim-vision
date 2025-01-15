import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_custom_text_field.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_dhikr_count_widget.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import '../../../blocs/tasbeeh_screen_bloc/tasbeeh_screen_create_dhikr_bloc/tasbeeh_screen_new_dhikr_bloc.dart';

class TasbeehScreenCreateNewDhikr extends StatefulWidget {
  const TasbeehScreenCreateNewDhikr({Key? key}) : super(key: key);

  @override
  State<TasbeehScreenCreateNewDhikr> createState() => _TasbeehScreenCreateNewDhikrState();
}

class _TasbeehScreenCreateNewDhikrState extends State<TasbeehScreenCreateNewDhikr> {
  /*-----------------------------------------------controllers----------------------------------------------*/
  TextEditingController dhikrNameController = TextEditingController();
  TextEditingController dhikrRewardController = TextEditingController();
  TextEditingController dhikrPronunciationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasbeehScreenNewDhikrBloc>(context).add(TasbeehScreenNewDhikrNumberCountEvent(0, -1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('create_new_dhikr'.tr(), true, [], kStyleTextW700CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'dhikr'.tr(),
                        style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                      ),
                      TextSpan(text: '*', style: kStyleTextW500CR.copyWith(fontSize: 10.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 36.h,
                  child: TasbeehScreenCustomTextField(controller: dhikrNameController, hintText: 'dhikr_name'.tr()),
                ),
                SizedBox(height: 16.h),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'count'.tr(),
                        style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                      ),
                      TextSpan(text: '*', style: kStyleTextW500CR.copyWith(fontSize: 10.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                        onPressed: () {
                          BlocProvider.of<TasbeehScreenNewDhikrBloc>(context).add(TasbeehScreenNewDhikrCounterDecreaseEvent());
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Flexible(
                      flex: 7,
                      fit: FlexFit.tight,
                      child: Container(
                        height: 37.h,
                        padding: EdgeInsets.all(8.0.r),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.circular(4.0.r),
                          border: Border.all(
                            color: kColorGrey,
                            width: 0.1.w,
                          ),
                        ),
                        child: Center(
                          child: BlocBuilder<TasbeehScreenNewDhikrBloc, TasbeehScreenNewDhikrState>(
                            // buildWhen: (previous, current) =>
                            //     current is TasbeehScreenNewDhikrCounterState || current is TasbeehScreenNewDhikrCounterState,
                            builder: (context, state) {
                              if (state is TasbeehScreenNewDhikrCounterState) {
                                return Text(
                               context.locale.toString()=='en'?state.counter.toString():   convertToBanglaNumber(
                                    state.counter.toString(),
                                  ),
                                  style: kStyleTextW700CP.copyWith(fontSize: 18.0.sp),
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return Text(
                                  '0',
                                  style: kStyleTextW700CP.copyWith(fontSize: 18.0.sp),
                                  textAlign: TextAlign.center,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                        onPressed: () {
                          BlocProvider.of<TasbeehScreenNewDhikrBloc>(context).add(TasbeehScreenNewDhikrCounterIncreaseEvent());
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                    // const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 40.h,
                  child: BlocBuilder<TasbeehScreenNewDhikrBloc, TasbeehScreenNewDhikrState>(
                    builder: (context, state) {
                      if (state is TasbeehScreenNewDhikrCounterState) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.numbers.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 16.0.w),
                                child: DhikrCountWidget(
                                  backgroundColor: state.index == index ? kColorPrimary : kColorGrey.withOpacity(0.1),
                                  title: state.numbers[index].toString(),
                                  textColor: state.index == index ? kColorWhite : kColorGrey,
                                  borderColor: state.index == index ? Colors.transparent : kColorGrey,
                                  onTap: () {
                                    BlocProvider.of<TasbeehScreenNewDhikrBloc>(context).add(TasbeehScreenNewDhikrNumberCountEvent(state.numbers[index], index));
                                  },
                                ),
                              );
                            });
                      } else {
                        return const Text('error');
                      }
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                TasbeehScreenCustomTextField(
                  controller: dhikrRewardController,
                  hintText: 'reward'.tr(),
                  maxLines: 4,
                ),
                SizedBox(height: 12.h),
                // TasbeehScreenCustomTextField(
                //   controller: dhikrPronunciationController,
                //   hintText: 'Pronunciation',
                //   maxLines: 4,
                // ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColorWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'cancel'.tr(),
                          style: kStyleTextW700CP.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (dhikrNameController.text.isEmpty) {

                            return;
                          }
                          Map<String, dynamic> createNewDhikr = {'name': dhikrNameController.text,
                            'count': 0, 'reward': dhikrRewardController.text, 'pronunciation': dhikrPronunciationController.text};
                          BlocProvider.of<TasbeehScreenNewDhikrBloc>(context).add(TasbeehScreenNewDhikrSaveEvent(createNewDhikr));

                          Navigator.pop(context);
                        },
                        child: Text('save_dhikr'.tr(), style: kStyleTextW700CW.copyWith(fontSize: 14.sp)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
