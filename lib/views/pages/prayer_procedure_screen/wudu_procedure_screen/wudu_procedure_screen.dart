import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/wudu_procedure_bloc/wudu_procedure_bloc.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import '../../../../global_variable.dart';
import '../../../common_widgets/arabic_line_splitter.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../themes/light_theme. dart.dart';

class WuduProcedureScreen extends StatefulWidget {
  const WuduProcedureScreen({Key? key}) : super(key: key);

  @override
  State<WuduProcedureScreen> createState() => _WuduProcedureScreenState();
}

class _WuduProcedureScreenState extends State<WuduProcedureScreen> {
  int prevCounter = 0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
   context.read<WuduProcedureBloc>().add(WuduProcedureLoadedEvent(0));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('wudu_procedure'.tr(), true, [], kStyleTextW600CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<WuduProcedureBloc, WuduProcedureState>(
        builder: (context, state) {
          if (state is WuduProcedureInitialState) {
            return const Center(child: DefaultCircularProgressIndicator());
          } else if (state is WuduProcedureLoadedState) {
            // print(state.wuduData.imageUrl)
            return Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                children: [
                  state.counter == 9
                      ? const SizedBox.shrink()
                      : Expanded(
                          flex: 7,
                          child: SvgPicture.asset(
                            state.wuduData.imageUrl,
                            fit: BoxFit.fill,
                            width: deviceWidth.w,
                            semanticsLabel: 'Logo',
                          ),
                        ),
                  SizedBox(height: 4.h),
                  Expanded(
                    flex: state.counter == 9 ? 18 : 11,
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
                                state.wuduData.detailsInBangla,
                                textStyleForBangla: kStyleTextW400CGR.copyWith(fontSize: 15.sp, color: kColorBlack),
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
                            borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                            color: prevCounter>0? kColorPrimary :kColorPrimary.withOpacity(.5),
                          ),
                          child: IconButton(
                            onPressed:prevCounter>0? () {
                              context.read<WuduProcedureBloc>().add(WuduProcedureDecrementEvent());
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
                          child: Text((state.counter + 1).toString(), style: kStyleTextW600CP.copyWith(fontSize: 14.sp)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                            color: state.isLastindex==true ? kColorPrimary.withOpacity(.5): kColorPrimary,
                          ),
                          child: IconButton(
                            onPressed:state.isLastindex==true?null: () {
                              context.read<WuduProcedureBloc>().add(WuduProcedureIncrementEvent());
                              print(
                                  'prev count ${prevCounter.toString()}');
                              print(
                                  'state count ${state.counter.toString()}');
                              if (prevCounter > state.counter) {
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
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }
}
