import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/greetings_blocs/greetings_bloc/greetingsbloc_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/wallpapers.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

import '../../common_widgets/custom_page_route_widget.dart';
import '../../themes/light_theme. dart.dart';

class GreetingMessages extends StatefulWidget {
  const GreetingMessages({Key? key}) : super(key: key);

  @override
  State<GreetingMessages> createState() => _GreetingMessagesState();
}

class _GreetingMessagesState extends State<GreetingMessages> {
  bool isInternet = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GreetingsblocBloc>(context).add(GreetingLodedEvent());
    isInternest();
  }

  isInternest() async {
    isInternet = await CommonFunctions().hasInternetConnection();

    if (!isInternet) {
      final snackBar = aweSomeSnackBar(title: 'no_internet_connection'.tr(), subTitle: "please_try_with_internet_connection".tr(), contentType: ContentType.warning, duration: 3000);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('greeting_messages'.tr(), false, [], kStyleTextW400CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<GreetingsblocBloc, GreetingsblocState>(
        builder: (context, state) {
          if (state is GreetingsblocInitial) {
            return const Center(
              child: DefaultCircularProgressIndicator(),
            );
          } else if (state is GreetingsLodedState) {
            return ListView.separated(
              itemCount: state.greetings.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      Navigator.of(context).push(CustomPageRoute(
                        child: Wallpapers(
                          greetingsTitle: state.greetings[index].greetingsInBangla,
                          greetingsImage: state.greetings[index].data.first.imageUrl,
                          greetingsSubtitle: state.greetings[index].data.first.meaningInBangla,
                        ),
                        direction: AxisDirection.left,
                      ));
                    },
                    title: Text(
                      state.greetings[index].greetingsInBangla,
                      style: kStyleTextW500CB.copyWith(fontSize: 14.sp),
                    ),
                    subtitle: Text(
                      state.greetings[index].data.first.meaningInBangla,
                      style: kStyleTextW400CG.copyWith(fontSize: 10.sp),
                    ),
                    trailing: state.isInternet
                        ? SizedBox(
                            height: 50.h,
                            width: 50.w,
                            child: Image.network(
                              state.greetings[index].data.first.imageUrl,
                              fit: BoxFit.fill,
                              color: kColorDeepGreen,
                            ))
                        : SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              color: kColorPrimary,
                            )));
              },
            );
          } else {
            return const Center(
              child: Text("Someting Worng"),
            );
          }
        },
      ),
    );
  }
}
