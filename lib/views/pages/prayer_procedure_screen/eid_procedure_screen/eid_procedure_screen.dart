import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/eid_procedure_bloc/eid_procedure_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import '../../../common_widgets/arabic_line_splitter.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../themes/light_theme. dart.dart';

class EidProcedureScreen extends StatefulWidget {
  const EidProcedureScreen({Key? key}) : super(key: key);

  @override
  State<EidProcedureScreen> createState() => _EidProcedureScreenState();
}

class _EidProcedureScreenState extends State<EidProcedureScreen> {
  EidProcedureBloc eidProcedureBloc = EidProcedureBloc();
  final _scrollController = ScrollController();
  int prevCounter = 0;

  @override
  void initState() {
    super.initState();
    eidProcedureBloc.add(EidProcedureLoadedEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('eid_procedure'.tr(), true, [],
          kStyleTextW600CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundIllustration),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: BlocBuilder<EidProcedureBloc, EidProcedureState>(
          bloc: eidProcedureBloc,
          builder: (context, state) {
            if (state is EidProcedureInitialState) {
              return const Center(child: DefaultCircularProgressIndicator());
            }
            if (state is EidProcedureLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          state.eidData.categoryInBangla,
                          textAlign: TextAlign.center,
                          style: kStyleTextW500CP.copyWith(
                              fontSize: 18.sp, color: kColorGreen),
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: 4.h),
                    Visibility(
                      visible: state.counter == 6 ||
                          state.counter == 7 ||
                          state.counter == 8 ||
                          state.counter == 9,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.0.h),
                        child: SvgPicture.asset(
                          state.eidData.data.first.imageUrl,
                          fit: BoxFit.fill,
                          width: deviceWidth.w,
                          semanticsLabel: 'Logo',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: state.counter == 6 ||
                              state.counter == 7 ||
                              state.counter == 8 ||
                              state.counter == 9
                          ? 11
                          : 20,
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
                                  state.eidData.data.first.detailsInBangla,
                                  textStyleForBangla:
                                      kStyleTextW400CGR.copyWith(
                                          fontSize: 15.sp, color: kColorBlack),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
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
                              onPressed: prevCounter > 0?() {
                                eidProcedureBloc
                                    .add(EidProcedureDecrementEvent());
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text('${state.counter + 1}',
                                style:
                                    kStyleTextW600CP.copyWith(fontSize: 14.sp)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0.r)),
                              color:state.isLastindex==true? kColorPrimary.withOpacity(.5):kColorPrimary,
                            ),
                            child: IconButton(
                              onPressed:state.isLastindex==true?null: () {
                                eidProcedureBloc
                                    .add(EidProcedureIncrementEvent());
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
                    // Expanded(
                    //   flex: 3,
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Expanded(
                    //           child: InkWell(
                    //             splashColor: Colors.transparent,
                    //             highlightColor: Colors.transparent,
                    //             onTap: () => eidProcedureBloc.add(EidProcedureDecrementEvent()),
                    //             child: Container(
                    //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0).r,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                    //                 color: kColorPrimary,
                    //               ),
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   Icon(
                    //                     Icons.arrow_back_rounded,
                    //                     color: kColorWhite,
                    //                     size: 18.w,
                    //                   ),
                    //                   SizedBox(width: 4.w),
                    //                   Text(
                    //                     'Previous',
                    //                     style: kStyleTextW500CW.copyWith(
                    //                       fontSize: 16.sp,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //
                    //         SizedBox(
                    //           width: 40.w,
                    //         ),
                    //         // Container(
                    //         //   padding: const EdgeInsets.all(4.0).r,
                    //         //   decoration: BoxDecoration(
                    //         //     borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                    //         //     color: kColorPrimary,
                    //         //   ),
                    //         //   child: IconButton(
                    //         //     onPressed: () {
                    //         //       eidProcedureBloc.add(EidProcedureDecrementEvent());
                    //         //     },
                    //         //     color: kColorWhite,
                    //         //     padding: const EdgeInsets.all(4).r,
                    //         //     constraints: const BoxConstraints(),
                    //         //     icon: const Icon(Icons.arrow_back_ios_new),
                    //         //   ),
                    //         // ),
                    //
                    //         // Padding(
                    //         //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    //         //   child: Text((state.counter + 1).toString(), style: kStyleTextW600CP.copyWith(fontSize: 14.sp)),
                    //         // ),
                    //         Expanded(
                    //           child: InkWell(
                    //             splashColor: Colors.transparent,
                    //             highlightColor: Colors.transparent,
                    //             onTap: () => eidProcedureBloc.add(EidProcedureIncrementEvent()),
                    //             child: Container(
                    //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0).r,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                    //                 color: kColorPrimary,
                    //               ),
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   Text(
                    //                     'Next',
                    //                     style: kStyleTextW500CW.copyWith(
                    //                       fontSize: 16.sp,
                    //                     ),
                    //                   ),
                    //                   SizedBox(width: 4.w),
                    //                   Icon(
                    //                     Icons.arrow_forward_rounded,
                    //                     color: kColorWhite,
                    //                     size: 18.w,
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //
                    //         // Container(
                    //         //   padding: const EdgeInsets.all(4.0).r,
                    //         //   decoration: BoxDecoration(
                    //         //     borderRadius: BorderRadius.all(Radius.circular(50.0.r)),
                    //         //     color: kColorPrimary,
                    //         //   ),
                    //         //   child: IconButton(
                    //         //     onPressed: () {
                    //         //       eidProcedureBloc.add(EidProcedureIncrementEvent());
                    //         //     },
                    //         //     color: kColorWhite,
                    //         //     padding: const EdgeInsets.all(4).r,
                    //         //     constraints: const BoxConstraints(),
                    //         //     icon: const Icon(Icons.arrow_forward_ios),
                    //         //   ),
                    //         // ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            } else {
              return const Text('error');
            }
          },
        ),
      ),
    );
  }
}
