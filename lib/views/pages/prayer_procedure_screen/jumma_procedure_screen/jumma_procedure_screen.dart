import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/jumma_procedure_bloc/jumma_procedure_bloc.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import '../../../../global_variable.dart';
import '../../../common_widgets/arabic_line_splitter.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../themes/light_theme. dart.dart';

class JummaProcedureScreen extends StatefulWidget {
  const JummaProcedureScreen({Key? key}) : super(key: key);

  @override
  State<JummaProcedureScreen> createState() => _JummaProcedureScreenState();
}

class _JummaProcedureScreenState extends State<JummaProcedureScreen> {
  JummaProcedureBloc jummaProcedureBloc = JummaProcedureBloc();
  final _scrollController = ScrollController();
  int prevCounter = 0;

  @override
  void initState() {
    super.initState();
    jummaProcedureBloc.add(JummaProcedureLoadedEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('jumma_procedure'.tr(), true, [], kStyleTextW600CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<JummaProcedureBloc, JummaProcedureState>(
        bloc: jummaProcedureBloc,
        builder: (context, state) {
          if (state is JummaProcedureInitialState) {
            return const Center(child: DefaultCircularProgressIndicator());
          } else if (state is JummaProcedureLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        state.jummaData[state.counter].categoryInBangla,
                        textAlign: TextAlign.center,
                        style: kStyleTextW500CP.copyWith(fontSize: 18.sp, color: kColorGreen),
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: 4.h),
                  Expanded(
                    flex: 20,
                    child: Card(
                      surfaceTintColor: kColorWhite,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).r,
                        child: SizedBox(
                          width: deviceWidth,
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              arabicLineSplitter(
                                state.jummaData[state.counter].data.first.detailsInBangla,
                                textStyleForBangla: kStyleTextW400CGR.copyWith(fontSize: 15.sp, color: kColorBlack),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  (state.counter + 1) != state.jummaData.length
                      ? Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      jummaProcedureBloc.add(JummaProcedureDecrementEvent());
                                      prevCounter = state.counter;
                                      if (prevCounter > 0) {
                                        prevCounter--;
                                        _scrollController.jumpTo(-100);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0).r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                                        color: kColorPrimary,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_rounded,
                                            color: kColorWhite,
                                            size: 18.w,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Previous',
                                            style: kStyleTextW500CW.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      jummaProcedureBloc.add(JummaProcedureIncrementEvent());
                                      prevCounter++;
                                      if (prevCounter > state.counter + 1) {
                                        return;
                                      }
                                      _scrollController.jumpTo(-100);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0).r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                                        color: kColorPrimary,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Next',
                                            style: kStyleTextW500CW.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: kColorWhite,
                                            size: 18.w,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      jummaProcedureBloc.add(JummaProcedureDecrementEvent());
                                      prevCounter = state.counter;
                                      if (prevCounter > 0) {
                                        prevCounter--;
                                        _scrollController.jumpTo(-100);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0).r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                                        color: kColorPrimary,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_rounded,
                                            color: kColorWhite,
                                            size: 18.w,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Previous',
                                            style: kStyleTextW500CW.copyWith(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/salatProcedure',
                                        arguments: {
                                          'waktName': 'Jummah',
                                          'waktNametitle': 'Jummah',
                                          'rakatType': 'sunnah',
                                          'rakatNumber': '2',
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0).r,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                                              color: kColorGreen,
                                            ),
                                            child: Text(
                                              'Start Salah',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: kStyleTextW500CW.copyWith(
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}
