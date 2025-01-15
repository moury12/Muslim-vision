import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/janaja_procedure_bloc/janaja_procedure_bloc.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import '../../../../global_variable.dart';
import '../../../common_widgets/arabic_line_splitter.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../themes/light_theme. dart.dart';

class JanajaProcedureScreen extends StatefulWidget {
  const JanajaProcedureScreen({Key? key}) : super(key: key);

  @override
  State<JanajaProcedureScreen> createState() => _JanajaProcedureScreenState();
}

class _JanajaProcedureScreenState extends State<JanajaProcedureScreen> {
  JanajaProcedureBloc janajaProcedureBloc = JanajaProcedureBloc();
  final _scrollController = ScrollController();
  int prevCounter = 0;

  @override
  void initState() {
    super.initState();
    janajaProcedureBloc.add(JanajaProcedureLoadedEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('janaja_procedure'.tr(), true, [],
          kStyleTextW600CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<JanajaProcedureBloc, JanajaProcedureState>(
        bloc: janajaProcedureBloc,
        builder: (context, state) {
          if (state is JanajaProcedureInitialState) {
            return const Center(child: DefaultCircularProgressIndicator());
          } else if (state is JanajaProcedureLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: SvgPicture.asset(
                      state.janajaData.imageUrl,
                      fit: BoxFit.fill,
                      width: deviceWidth.w,
                      semanticsLabel: 'Logo',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    flex: 11,
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
                                state.janajaData.detailsInBangla,
                                textStyleForBangla: kStyleTextW400CGR.copyWith(
                                    fontSize: 15.sp, color: kColorBlack),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0.r)),
                            color:prevCounter > 0? kColorPrimary:kColorPrimary.withOpacity(.5),
                          ),
                          child: IconButton(
                            onPressed:prevCounter > 0? () {
                              janajaProcedureBloc
                                  .add(JanajaProcedureDecrementEvent());
                              prevCounter = state.counter;
                              if (prevCounter > 0) {
                                prevCounter--;
                                _scrollController.jumpTo(-100);
                              }
                            }:null,
                            color: kColorWhite,
                            padding: const EdgeInsets.all(4).r,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text((state.counter + 1).toString(),
                              style:
                                  kStyleTextW600CP.copyWith(fontSize: 14.sp)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0.r)),
                            color: state.isLastindex==true
                                ? kColorPrimary.withOpacity(.5)
                                : kColorPrimary,
                          ),
                          child: IconButton(
                            onPressed:state.isLastindex==true
                                ? null
                                : () {
                                    janajaProcedureBloc
                                        .add(JanajaProcedureIncrementEvent());
                                    prevCounter++;
                                    if (prevCounter > state.counter + 1) {
                                      return;
                                    }
                                    _scrollController.jumpTo(-100);
                                  },
                            color: kColorWhite,
                            padding: const EdgeInsets.all(4).r,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
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
