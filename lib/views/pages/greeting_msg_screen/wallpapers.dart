// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/greetings_blocs/greetings_bg_bloc/greetings_background_bloc.dart';
import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_edit_share.dart';

import '../../common_widgets/custom_app_bar.dart';
import '../../themes/light_theme. dart.dart';

class Wallpapers extends StatefulWidget {
  final String greetingsTitle;
  final String greetingsImage;
  final String greetingsSubtitle;

  const Wallpapers({
    Key? key,
    required this.greetingsTitle,
    required this.greetingsImage,
    required this.greetingsSubtitle,
  }) : super(key: key);

  @override
  State<Wallpapers> createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GreetingsBackgroundBloc>(context).add(GreetingsBackgroundLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        'backgrounds1'.tr(),
        false,
        [],
        kStyleTextW400CW.copyWith(fontSize: 16.sp),
        context,
            () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: BlocListener<GreetingsBackgroundBloc, GreetingsBackgroundState>(
          listener: (context, state) {
            if (state is GreetingsBackgroundErrorState) {
              final snackBar = aweSomeSnackBar(
                title: "no_internet_connection".tr(),
                subTitle: "please_try_with_internet_connection".tr(),
                contentType: ContentType.warning,
                duration: 2000,
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
          child: BlocBuilder<GreetingsBackgroundBloc, GreetingsBackgroundState>(
            builder: (context, state) {
              if (state is GreetingsBackgroundLoadedState) {
                return GridView.builder(
                  itemCount: state.greetingBackgrounds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: GreetingEditShare(
                              greetingsTitle: widget.greetingsTitle,
                              greetingsBackgroundImg: state.greetingBackgrounds[index].toString(),
                              greetingsImg: widget.greetingsImage,
                              greetingsSubtitleTitle: widget.greetingsSubtitle,
                            ),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: state.greetingBackgrounds[index].toString(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    );
                  },
                );
              } /*else if (state is GreetingsBackgroundLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kColorPrimary,
                  ),
                );
              }*/ else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
