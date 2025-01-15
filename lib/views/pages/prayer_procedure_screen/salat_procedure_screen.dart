import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/blocs/salat_procedure_bloc/salat_procedure_bloc.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/arabic_line_splitter.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

class SalatProcedureScreen extends StatefulWidget {
  const SalatProcedureScreen({Key? key}) : super(key: key);

  @override
  State<SalatProcedureScreen> createState() => _SalatProcedureScreenState();
}

class _SalatProcedureScreenState extends State<SalatProcedureScreen> {
  /*-----------------------------------------------Variables----------------------------------------------*/
  SalatProcedureBloc salatProcedureBloc = SalatProcedureBloc();
  int prevCounter = 0;
  Map arguments = {};
  final _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)!.settings.arguments as Map;
    salatProcedureBloc.add(SalatProcedureLoadedEvent(arguments));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          '${arguments['waktNametitle'].toString().toLowerCase().tr()} ${"salat_procedure".tr()}',
          true,
          [],
          kStyleTextW600CW.copyWith(fontSize: 14.sp),
          context, () {
        Navigator.pop(context);
      }),
      body: BlocConsumer(
        bloc: salatProcedureBloc,
        listenWhen: (previous, current) => current is SalatProcedureActionState,
        buildWhen: (previous, current) => current is! SalatProcedureActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SalatProcedureInitialState) {
            return const Center(child: DefaultCircularProgressIndicator());
          } else if (state is SalatProcedureLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                children: [
                  SizedBox(height: 6.h),
                  Expanded(
                    flex: 7,
                    child: SvgPicture.asset(
                        state.salatProcedureInitialData.imageUrl,
                        fit: BoxFit.fill,
                        width: deviceWidth.w,
                        semanticsLabel: 'Logo'),
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    flex: 12,
                    child: Card(
                      surfaceTintColor: kColorWhite,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).r,
                        child: SizedBox(
                          width: deviceWidth.w,
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.salatProcedureInitialData
                                        .categoryInBangla,
                                    style: kStyleTextW500CP.copyWith(
                                        fontSize: 17.sp, color: kColorGreen),
                                  ),
                                  Text(
                                    '(রাকাত : ${convertToBanglaNumber(state.rakatNumber.toString())})',
                                    style: kStyleTextW500CP.copyWith(
                                        fontSize: 16.sp, color: kColorBlack),
                                  ),
                                ],
                              ),
                              const Divider(),
                              arabicLineSplitter(
                                state.salatProcedureInitialData.detailsInBangla,
                                textStyleForBangla: kStyleTextW400CGR.copyWith(
                                  fontSize: 15.sp,
                                  color: kColorBlack,
                                ),
                              ),
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
                            color: prevCounter <= 0
                                ? kColorPrimary.withOpacity(.5)
                                : kColorPrimary,
                          ),
                          child: IconButton(
                            onPressed: prevCounter <= 0
                                ? null
                                : () {
                                    salatProcedureBloc.add(
                                        SalatProcedureDecrementCountEvent());
                                    prevCounter = state.counter;
                                    if (prevCounter > 0) {
                                      prevCounter--;
                                      _scrollController.jumpTo(-100);
                                    }
                                  },
                            color: kColorWhite,
                            padding: const EdgeInsets.all(4).r,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.r),
                          child: Text('${state.counter + 1}',
                              style:
                                  kStyleTextW600CP.copyWith(fontSize: 14.sp)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0.r)),
                            color: prevCounter > state.counter
                                ? kColorPrimary.withOpacity(.5)
                                : kColorPrimary,
                          ),
                          child: IconButton(
                            onPressed: prevCounter > state.counter
                                ? null
                                : () {
                                    // log(state.length.toString());
                                    // log(state.counter.toString());
                                    // log(prevCounter.toString());
                                    salatProcedureBloc.add(
                                        SalatProcedureIncrementCountEvent());
                                    print(
                                        'prev count ${prevCounter.toString()}');
                                    print(
                                        'state count ${state.counter.toString()}');
                                    if (prevCounter > state.counter) {
                                      print('prev count');
                                      return;
                                    } else {
                                      prevCounter = state
                                          .counter; // Update after comparison
                                      prevCounter++; // Increment for the next step
                                      _scrollController.jumpTo(-100);
                                    }
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
          } else if (state is SalatProcedureErrorState) {
            return const Center(
              child: Text('Error to get Data'),
            );
          } else {
            return const Center(child: Text('error'));
          }
        },
      ),
    );
  }
}
