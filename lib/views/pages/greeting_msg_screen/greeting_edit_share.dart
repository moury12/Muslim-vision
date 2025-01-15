// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim_vision/blocs/greetings_blocs/greetings_edit_bloc/greetings_share_edit_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/image_editor.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/text_editor.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/widget_to_image.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class GreetingEditShare extends StatefulWidget {
  final String greetingsTitle;
  final String greetingsSubtitleTitle;
  final String greetingsImg;
  final String greetingsBackgroundImg;
  const GreetingEditShare({
    Key? key,
    required this.greetingsTitle,
    required this.greetingsSubtitleTitle,
    required this.greetingsImg,
    required this.greetingsBackgroundImg,
  }) : super(key: key);

  @override
  State<GreetingEditShare> createState() => _GreetingEditShareState();
}

class _GreetingEditShareState extends State<GreetingEditShare> {
  GlobalKey imagekey = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GreetingsShareEditBloc>(context).add(ImageOffsetEvent(
        imageoffest: const Offset(40, 50),
        opacityValue: 0.9,
        color: Colors.white,
        height: 100));
    BlocProvider.of<GreetingsShareEditBloc>(context).add(TextOffsetEvent(
        textOffset: const Offset(40, 150),
        fontSize: widget.greetingsImg == '' ? 12.sp : 20.sp,
        textcolor: const Color.fromARGB(255, 245, 243, 243),
        opacityValue: 0.9));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          'backgrounds'.tr(),
          false,
          [
            IconButton(
                onPressed: () {
                  BlocProvider.of<GreetingsShareEditBloc>(context)
                      .add(ShareImageEvent(imgkey: imagekey));
                },
                icon: Icon(
                  Icons.share,
                  size: 20.sp,
                ))
          ],
          kStyleTextW400CW.copyWith(fontSize: 16.sp),
          context, () {
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: WidgetToImage(builder: (key) {
              imagekey = key;

              return Stack(
                children: [
                  Image.network(
                    widget.greetingsBackgroundImg,
                    fit: BoxFit.fill,
                    // height: 380.h,
                    height: double.infinity,
                    width: deviceWidth.w,
                  ),
                  BlocBuilder<GreetingsShareEditBloc, GreetingsShareEditState>(
                    buildWhen: (previous, current) =>
                        current is ImageOffsetState,
                    builder: (context, state) {
                      if (state is ImageOffsetState) {
                        return Positioned(
                          left: state.imageoffset.dx,
                          top: state.imageoffset.dy,
                          child: GestureDetector(
                            onTap: () =>
                                BlocProvider.of<GreetingsShareEditBloc>(context)
                                    .add(ImageOffsetEvent()),
                            onPanUpdate: (details) {
                              BlocProvider.of<GreetingsShareEditBloc>(context)
                                  .add(ImageOffsetEvent(
                                      imageoffest: state.imageoffset +=
                                          details.delta,
                                      opacityValue: state.opacityValue));
                            },
                            child: Opacity(
                                opacity: state.opacityValue!,
                                child: widget.greetingsImg != ""
                                    ? Image.network(widget.greetingsImg,
                                        height: state.height!.h,
                                        width: state.height! * 3.w,
                                        fit: BoxFit.contain,
                                        color: state.color)
                                    : const SizedBox.shrink()),
                          ),
                        );
                      } else {
                        return const Center(
                            child: DefaultCircularProgressIndicator());
                      }
                    },
                  ),
                  BlocBuilder<GreetingsShareEditBloc, GreetingsShareEditState>(
                    buildWhen: (previous, current) =>
                        current is TextOffsetState,
                    builder: (context, state) {
                      if (state is TextOffsetState) {
                        return Positioned(
                          left: state.textoffset.dx,
                          top: state.textoffset.dy,
                          child: GestureDetector(
                            onTap: () =>
                                BlocProvider.of<GreetingsShareEditBloc>(context)
                                    .add(TextOffsetEvent()),
                            onPanUpdate: (details) {
                              BlocProvider.of<GreetingsShareEditBloc>(context)
                                  .add(TextOffsetEvent(
                                      textOffset: state.textoffset +=
                                          details.delta,
                                      fontSize: state.fontsize,
                                      fontFamaly: state.fontFamily,
                                      opacityValue: state.opacityValue));
                            },
                            child: Center(
                              child: Opacity(
                                opacity: state.opacityValue!,
                                child: widget.greetingsTitle.isNotEmpty
                                    ? SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.8, // Adjust the width as needed
                                        child: Column(
                                          children: [
                                            Text(
                                              widget.greetingsTitle,
                                              textAlign: TextAlign
                                                  .center, // Optionally, you can adjust the text alignment
                                              style: state.fontFamily!.copyWith(
                                                fontSize: state.fontsize!.sp,
                                                fontFamily: 'Naskh',
                                                color: state.color,
                                              ),
                                            ),
                                            widget.greetingsSubtitleTitle
                                                    .isEmpty
                                                ? const SizedBox.shrink()
                                                : Text(
                                                    widget
                                                        .greetingsSubtitleTitle,
                                                    textAlign: TextAlign
                                                        .center, // Optionally, you can adjust the text alignment
                                                    style: state.fontFamily!
                                                        .copyWith(
                                                      fontSize:
                                                          state.fontsize!.sp -
                                                              5,
                                                      color: state.color,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        );
                      }
                      return const Center(
                          child: DefaultCircularProgressIndicator());
                    },
                  ),
                  Positioned(
                      bottom: 2.h,
                      left: 10.w,
                      right: 10.w,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          greeting_bottom,
                          height: 30.h,
                          width: deviceWidth.h,
                          fit: BoxFit.fill,
                        ),
                      )),
                ],
              );
            }),
          ),
          Expanded(
            flex: 5,
            child: BlocBuilder<GreetingsShareEditBloc, GreetingsShareEditState>(
              // buildWhen: (previous, current) => current is TextOffsetState,
              builder: (context, state) {
                if (state is TextOffsetState) {
                  return TextEditorWidget(widget: widget, state: state);
                } else if (state is ImageOffsetState) {
                  return ImageEditWidget(state: state);
                }
                return const Text('rerro');
              },
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: SizedBox(
          //     height: 50.h,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         RowButtons(
          //           onTap: () {
          //             BlocProvider.of<GreetingsShareEditBloc>(context).add(TextOffsetEvent());
          //           },
          //           icondata: Icons.edit_note_rounded,
          //           title: 'Text Edit',
          //         ),
          //         // const Text(
          //         //   '|',
          //         //   style: kStyleTextW400CB,
          //         // ),

          //         RowButtons(
          //           onTap: () {
          //             BlocProvider.of<GreetingsShareEditBloc>(context).add(ImageOffsetEvent());
          //           },
          //           icondata: Icons.image_outlined,
          //           title: 'Image Edit',
          //         ),
          //         // const Text(
          //         //   '|',
          //         //   style: kStyleTextW400CW,
          //         // ),

          //         RowButtons(
          //           onTap: () {
          //             BlocProvider.of<GreetingsShareEditBloc>(context).add(ShareImageEvent(imgkey: imagekey));
          //           },
          //           icondata: Icons.share,
          //           title: 'Share Image',
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
      floatingActionButton: SizedBox(
        height: 45.h,
        width: 45.w,
        child: FloatingActionButton(
          onPressed: () => BlocProvider.of<GreetingsShareEditBloc>(context)
              .add(ShareImageEvent(imgkey: imagekey)),
          backgroundColor: kColorPrimary,
          tooltip: 'Share Image',
          elevation: 10,
          child: Icon(
            Icons.share,
            color: kColorWhite,
            size: 30.sp,
          ),
        ),
      ),
    );
  }
}
