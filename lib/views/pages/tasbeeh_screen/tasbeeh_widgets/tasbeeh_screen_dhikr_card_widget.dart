// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_all_dhikr_bloc/tasbeeh_screen_all_dhikr_bloc.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_tasbeeh_animation_bloc/tasbeeh_animation_bloc.dart';
import 'package:muslim_vision/database/boxes.dart';

import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_dhikr_count_widget.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../../controllers/services/static_data.dart';
import '../../../common_widgets/common_alert_dialog.dart';

class TasbeehScreenDhikrCard extends StatefulWidget {
  const TasbeehScreenDhikrCard({super.key});

  @override
  State<TasbeehScreenDhikrCard> createState() => _TasbeehScreenDhikrCardState();
}

class _TasbeehScreenDhikrCardState extends State<TasbeehScreenDhikrCard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasbeehScreenAllDhikrBloc>(context).add(TasbeehScreenAllDhikrLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          final dhikrBox = Boxes().tasbeehBox;
          if (dhikrBox.get('TasbeehInitialData').values.isEmpty) {
            BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationSingleDhikrEvent(StaticData().firstDhikr));
            BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationInitialDataSaveEvent());
          }
        }
      },
      child: BlocBuilder<TasbeehScreenAllDhikrBloc, TasbeehScreenAllDhikrState>(
        buildWhen: (previous, current) => current is TasbeehScreenAllDhikrLoadedState,
        builder: (context, state) {
          if (state is TasbeehScreenAllDhikrLoadedState) {
            if (state.allDhikr.isEmpty) {
              return Center(
                child: Text(
                  "dikir_not_found".tr(),
                  style: TextStyle(fontSize: 14.sp),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.allDhikr.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.allDhikr[index]['name'],
                                style: kStyleTextW600CB.copyWith(fontSize: 12.sp),
                              ),
                            ),
                            DhikrCountWidget(
                              backgroundColor: kColorPrimary,
                              title: state.allDhikr[index]['count'].toString(),
                              textColor: kColorWhite,
                              borderColor: kColorPrimary,
                              isBorderSide: true,
                              onTap: () {},
                            ),
                          ],
                        ),
                        state.allDhikr[index]['reward'].isEmpty ? const SizedBox.shrink() : SizedBox(height: 10.h),
                        Text(
                          state.allDhikr[index]['reward'].isEmpty ? '' : 'Virtue/ Reward:',
                          style: kStyleTextW500CG.copyWith(fontSize: 14.sp),
                        ),
                        Text(
                          state.allDhikr[index]['reward'].isEmpty ? '' : '${state.allDhikr[index]['reward']}',
                          style: kStyleTextW400CG.copyWith(fontSize: 12.sp),
                        ),
                        state.allDhikr[index]['reward'].isEmpty ? const SizedBox.shrink() : SizedBox(height: 12.h),
                        state.allDhikr[index]['reward'].isEmpty ? const SizedBox.shrink() : SizedBox(height: 4.h),
                        Row(
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: ((state.allDhikr[index]['name'] != "SubhanAllah") && (state.allDhikr[index]['name'] != "Alhamdulillah") && (state.allDhikr[index]['name'] != "Allahu Akbar")) ? 8 : 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kColorPrimary.withOpacity(0.1),
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                ),
                                onPressed: () async {
                                  BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationSingleDhikrEvent(state.allDhikr[index]));
                                  final dhikrBox = Boxes().tasbeehBox;
                                  await dhikrBox.put('TasbeehInitialData', {
                                    'counter': 0,
                                    'loop': 1,
                                    'singleDhikrData': state.allDhikr[index],
                                  });
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'start_now'.tr(),
                                  style: kStyleTextW600CP.copyWith(fontSize: 11.sp),
                                ),
                              ),
                            ),
                            ((state.allDhikr[index]['name'] != "SubhanAllah") && (state.allDhikr[index]['name'] != "Alhamdulillah") && (state.allDhikr[index]['name'] != "Allahu Akbar"))
                                ? Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 20.0.w),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kColorRed.withOpacity(0.1),
                                            elevation: 0,
                                            padding: EdgeInsets.symmetric(vertical: 4.h),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => CommonAlertDialog(
                                                title: 'are_your_sure_you_want_to_delete_this'.tr(),
                                                onTap: () {
                                                  BlocProvider.of<TasbeehScreenAllDhikrBloc>(context).add(TasbeehScreenAllDhikrDeleteEvent(state.allDhikr[index]['name']));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: kColorRed,
                                          ),
                                        )),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}
