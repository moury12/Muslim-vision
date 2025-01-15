import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_tasbeeh_animation_bloc/tasbeeh_animation_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/common_alert_dialog.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_screen_all_dhikrs.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/update_tasbeeh_object_popup.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../database/boxes.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({Key? key}) : super(key: key);

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  late final AnimationController controller;
  int count = 0;
  bool _stopDrag = false;

  @override
  void initState() {
    super.initState();
    //  BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehSoundEvent(isOn: false));
    WidgetsBinding.instance.addObserver(this);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationInitialEvent(controller));
    final Box dhikrBox = Boxes().tasbeehBox;
    Map initialDhikrData = dhikrBox.get('TasbeehInitialData');
    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationSingleDhikrEvent(initialDhikrData["singleDhikrData"]));
    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationLoadedEvent());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _appLifecycleState = state;
    if (_appLifecycleState != AppLifecycleState.resumed) {
      final dhikrBox = Boxes().tasbeehBox;
      if (dhikrBox.get('TasbeehInitialData').values.isNotEmpty) {
        BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationInitialDataSaveEvent());
      }
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationInitialDataSaveEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationInitialDataSaveEvent());
        }
      },
      child: Scaffold(
        appBar: customAppBar(
            'tasbeeh'.tr(),
            true,
            [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CommonAlertDialog(
                        title: 'are_your_sure_you_want_to_reset_this'.tr(),
                        onTap: () {
                          BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationResetEvent());
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.replay,
                    size: 20.sp,
                  )),
              BlocBuilder<TasbeehAnimationBloc, TasbeehAnimationState>(
                buildWhen: (previous, current) => current is TasbeehSoundState,
                builder: (context, state) {
                  if (state is TasbeehSoundState) {
                    count = state.count;

                    return IconButton(
                        onPressed: () {
                          count++;
                          if (count > 2) {
                            count = 0;
                          }
                          BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehSoundEvent(count: count));
                        },
                        icon: Icon(
                          state.count == 0
                              ? Icons.volume_down_sharp
                              : state.count == 1
                                  ? Icons.vibration
                                  : Icons.volume_off,
                          size: 20.sp,
                        ));
                  }
                  return IconButton(
                      onPressed: () {
                        BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehSoundEvent(count: count));
                      },
                      icon: const Icon(Icons.volume_down_sharp));
                },
              ),
            ],
            kStyleTextW500CW.copyWith(fontSize: 16.sp),
            context, () {
          BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationInitialDataSaveEvent());
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SvgPicture.asset(prayerScreenBanner, width: deviceWidth.w, fit: BoxFit.cover),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<TasbeehAnimationBloc, TasbeehAnimationState>(
                      buildWhen: (previous, current) => current is TasbeehAnimationLoopState,
                      builder: (context, state) {
                        if (state is TasbeehAnimationLoopState) {
                          return Text(
                            '${"loop".tr()} ${context.locale.toString() == 'en' ? state.loop.toString() : convertToBanglaNumber(state.loop.toString())}',
                            style: kStyleTextW600CW.copyWith(fontSize: 14.sp, height: 0),
                          );
                        } else {
                          return Text(
                            'Loop 1',
                            style: kStyleTextW600CW.copyWith(fontSize: 14.sp, height: 0),
                          );
                        }
                      },
                    ),
                    BlocBuilder<TasbeehAnimationBloc, TasbeehAnimationState>(
                      buildWhen: (previous, current) => current is TasbeehAnimationCounterState,
                      builder: (context, state) {
                        if (state is TasbeehAnimationCounterState) {
                          return Text(
                            context.locale.toString() == 'en' ? state.counter.toString() : convertToBanglaNumber(state.counter.toString()),
                            style: kStyleTextW700CW.copyWith(fontSize: 80.sp, height: 0),
                          );
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: Text(
                              '0',
                              style: kStyleTextW700CW.copyWith(fontSize: 80.sp, height: 0),
                            ),
                          );
                        }
                      },
                    ),
                    BlocBuilder<TasbeehAnimationBloc, TasbeehAnimationState>(
                      buildWhen: (previous, current) => current is TasbeehAnimationSingleDhikrState,
                      builder: (context, state) {
                        if (state is TasbeehAnimationSingleDhikrState) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '/${context.locale.toString() == 'en' ? state.singleDhikrData['count'].toString() : convertToBanglaNumber(state.singleDhikrData['count'].toString())}',
                                    style: kStyleTextW500CW.copyWith(fontSize: 20.sp, height: 0),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => UpdateTasbeehObjectPopUp(singleDhikrField: state.singleDhikrData),
                                      );
                                    },
                                    icon: const Icon(Icons.mode_edit_outlined),
                                    color: kColorWhite,
                                  )
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                state.singleDhikrData['name'],
                                overflow: TextOverflow.ellipsis,
                                style: kStyleTextW600CW.copyWith(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('target'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 12.sp, color: kColorWhite.withOpacity(0.7))),
                                        Text(context.locale.toString() == 'en' ? state.singleDhikrData['count'].toString() : convertToBanglaNumber(state.singleDhikrData['count'].toString()), style: kStyleTextW500CW.copyWith(fontSize: 12.sp))
                                      ],
                                    ),
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          CustomPageRoute(
                                            child: const TasbeehScreenAllDhikrs(),
                                            direction: AxisDirection.left,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(color: kColorGreen2, borderRadius: BorderRadius.circular(5.r), border: Border.all(color: kColorPrimary)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
                                          child: Text('all_dhikirs'.tr(), style: kStyleTextW700CW.copyWith(fontSize: 12.sp)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Text('error');
                        }
                      },
                    )
                  ],
                )
              ],
            ),
            // SizedBox(height: 8.h),

            StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateGesture) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationCounterEvent(count: count));
                  },
                  onHorizontalDragStart: (details) async {
                    final draggedPosition = MediaQuery.of(context).size.width - details.localPosition.dx;
                    if (draggedPosition < 60.w) {
                      _stopDrag = true;
                      setStateGesture(() {});
                      return;
                    }
                    _stopDrag = false;
                    setStateGesture(() {});
                    controller.reset();
                    // await  CommonFunctions().playSound("audios/tasbeeh.mp3");
                  },
                  onHorizontalDragEnd: (details) {
                    if (_stopDrag) {
                      return;
                    }
                    final dx = details.velocity.pixelsPerSecond.dx;
                    if (dx == 0) {
                      return;
                    }

                    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationDragEndEvent(dx, count));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Lottie.asset(
                        // height: deviceHeight * 0.4.h,
                        // width: deviceWidth.w,
                        // fit: BoxFit.cover,
                        "assets/json/tasbeeh_animation.json",
                        reverse: true,
                        controller: controller,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'tap_anywhere_to_begin'.tr(),
                          style: kStyleTextW500CG.copyWith(fontSize: 9.sp),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
