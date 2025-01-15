// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim_vision/blocs/greetings_blocs/greetings_edit_bloc/greetings_share_edit_bloc.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_edit_share.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/fonts_buttons.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/text_color_buttons.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class TextEditorWidget extends StatelessWidget {
  const TextEditorWidget({super.key, required this.widget, required this.state});

  final GreetingEditShare widget;
  final TextOffsetState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      'Font Size',
                      style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                    )),
                Expanded(
                  flex: 7,
                  child: Slider(
                    value: state.fontsize!,
                    min: 2.0.sp,
                    max: 50.0.sp,
                    thumbColor: kColorDeepGreen,
                    activeColor: kColorDeepGreen2,
                    onChanged: (value) {
                      BlocProvider.of<GreetingsShareEditBloc>(context).add(TextOffsetEvent(
                        textOffset: state.textoffset,
                        fontSize: value,
                        fontFamaly: state.fontFamily,
                      ));
                    },
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      '${state.fontsize!.toStringAsFixed(0)} pt',
                      style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                    )),
              ],
            ),
          ),
          const Divider(),
          // Padding(
          //   padding:  EdgeInsets.symmetric(
          //       horizontal: 10.sp,),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: <Widget>[
          //         CustomButton(
          //             text: widget.greetingsTitle,
          //             fontFamily: GoogleFonts.roboto()),
          //           SizedBox(
          //           width: 10.w,
          //         ),
          //         CustomButton(
          //             text: widget.greetingsTitle,
          //             fontFamily: GoogleFonts.openSans()),
          //           SizedBox(
          //           width: 10.w,
          //         ),
          //         CustomButton(
          //             text: widget.greetingsTitle,
          //             fontFamily: GoogleFonts.montserrat()),
          //           SizedBox(
          //           width: 10.w,
          //         ),
          //         CustomButton(
          //             text: widget.greetingsTitle,
          //             fontFamily: GoogleFonts.lobster()),
          //           SizedBox(
          //           width: 10.w,
          //         ),
          //         CustomButton(
          //             text: widget.greetingsTitle,
          //             fontFamily: GoogleFonts.aBeeZee()),
          //       ],
          //     ),
          //   ),
          // ),
          //  const Divider(),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      'Opacity',
                      style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                    )),
                Expanded(
                  flex: 10,
                  child: Slider(
                    value: state.opacityValue!,
                    min: 0.00,
                    max: 1,
                    thumbColor: kColorDeepGreen,
                    activeColor: kColorDeepGreen2,
                    onChanged: (value) {
                      BlocProvider.of<GreetingsShareEditBloc>(context).add(TextOffsetEvent(textOffset: state.textoffset, fontSize: state.fontsize, fontFamaly: state.fontFamily, opacityValue: value));
                    },
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${(state.opacityValue! * 100).toStringAsFixed(0)}%',
                      style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                    )),
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          Divider(),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SizedBox(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return TextColorButtons(istext: true, contexts: context, color: colors[index]);
                    }),
              )),
        ],
      ),
    );
  }
}
