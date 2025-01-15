// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/greetings_blocs/greetings_edit_bloc/greetings_share_edit_bloc.dart';


import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/text_color_buttons.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class ImageEditWidget extends StatelessWidget {
    ImageEditWidget({
    required this.state,
    super.key,
  });
  ImageOffsetState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'Size',
                    style: kStyleTextW400CB.copyWith(
                        fontSize: 14.sp),
                  )),
              Expanded(
                flex: 10,
                child: Slider(
                  value: state.height!,
                  min: 0.00,
                  max: 200,
                  thumbColor: kColorDeepGreen,
                  activeColor: kColorDeepGreen2,
                  onChanged: (value) {
                    BlocProvider.of<GreetingsShareEditBloc>(
                            context)
                        .add(ImageOffsetEvent(
                            height: value));
                  },
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                      '${(state.height!).toStringAsFixed(0)}px',
                    style: kStyleTextW400CB.copyWith(
                        fontSize: 14.sp),
                  )),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Opacity',
                    style: kStyleTextW400CB.copyWith(
                        fontSize: 14.sp),
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
                    BlocProvider.of<GreetingsShareEditBloc>(
                            context)
                        .add(ImageOffsetEvent(
                            opacityValue: value));
                  },
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    '${(state.opacityValue! * 100).toStringAsFixed(0)}%',
                    style: kStyleTextW400CB.copyWith(
                        fontSize: 14.sp),
                  )),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 0),
          child: SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context,index){
                return TextColorButtons(
                    istext: false,
                    contexts: context,
                    color: colors[index]);
            
            }),
          ),
        ),
      ],
    );
  }
}

