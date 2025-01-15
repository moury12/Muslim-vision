import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_top_section_bloc/home_screen_top_section_bloc.dart';
import 'package:muslim_vision/components/feedback_button.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_top_right_widget.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_digital_clock.dart';
import 'package:muslim_vision/views/pages/settings_screen/setting_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import 'home_screen_top_card_zone.dart';

class HomeScreenTopSection extends StatefulWidget {
  const HomeScreenTopSection({super.key});

  @override
  State<HomeScreenTopSection> createState() => _HomeScreenTopSectionState();
}

class _HomeScreenTopSectionState extends State<HomeScreenTopSection> {
  @override
  void initState() {
    routeName = runtimeType.toString();
    super.initState();
    BlocProvider.of<HomeScreenTopSectionBloc>(context).add(HomeScreenTopSectionLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final lat = Boxes().utilsBox.get('lat');
    final long = Boxes().utilsBox.get('long');

    String locale = Localizations.localeOf(context).languageCode;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SvgPicture.asset(
          header,
          width: deviceWidth.w,
          fit: BoxFit.fill,
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 15.h),
              child: BlocBuilder<HomeScreenTopSectionBloc, HomeScreenTopSectionState>(
                builder: (context, state) {
                  if (state is HomeScreenTopSectionInitialState) {
                    return const DefaultCircularProgressIndicator();
                  } else if (state is HomeScreenTopSectionNoLocationState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              calendar,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: lat == null && long == null
                                        ? () async {
                                            await CommonFunctions().processLocationPermission(context, false);
                                          }
                                        : null,
                                    child: Text("enable_location".tr(), style: kStyleTextW600CW.copyWith(fontSize: 12.sp))),
                                Text(DateFormat('d LLLL, y', locale).format(DateTime.now()), style: kStyleTextW400CW.copyWith(fontSize: 12.sp)),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.settings,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingScreen(
                                        isMed: false,
                                      ),
                                    ));
                              },
                            ),
                            GestureDetector(
                                onTap: lat == null && long == null
                                    ? () async {
                                        await CommonFunctions().processLocationPermission(context, false);
                                      }
                                    : null,
                                child: CustomTopRightWidget(city: "enable_location".tr()))
                          ],
                        ),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: 'sunrise'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                  TextSpan(text: context.locale.toString() == 'en' ? '00:00  |  ' : '${convertToBanglaNumber('00:00')}  |  ', style: kStyleTextW600CW.copyWith(fontSize: 10.sp)),
                                  TextSpan(text: 'sunset'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                  TextSpan(text: context.locale.toString() == 'en' ? '00:00' : convertToBanglaNumber('00:00'), style: kStyleTextW600CW.copyWith(fontSize: 10.sp)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(clock, height: 12.h, width: 12.w),
                            SizedBox(width: 4.w),
                            CurrentTime(counter: DateTime.now())
                          ],
                        ),
                      ],
                    );
                  } else if (state is HomeScreenTopSectionLoadedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              calendar,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${state.topSectionData['todayDateHijri']}', style: kStyleTextW600CW.copyWith(fontSize: 12.sp)),
                                Text(DateFormat('d LLLL, y', locale).format(DateTime.now()), style: kStyleTextW400CW.copyWith(fontSize: 12.sp)),
                              ],
                            ),
                            const Spacer(),
                            CustomTopRightWidget(city: state.topSectionData['city'])
                          ],
                        ),
                        // SizedBox(height: 4.h),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: 'sunrise'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                  TextSpan(text: context.locale.toString() == 'en' ? '${state.topSectionData['sunrise']}  |  ' : '${convertToBanglaNumber(state.topSectionData['sunrise'])}  |  ', style: kStyleTextW600CW.copyWith(fontSize: 10.sp)),
                                  TextSpan(text: 'sunset'.tr(), style: kStyleTextW400CW.copyWith(fontSize: 10.sp, color: kColorWhite.withOpacity(0.7))),
                                  TextSpan(
                                      text: context.locale.toString() == 'en' ? DateFormat('hh:mm').format(DateFormat('HH:mm').parse(state.topSectionData['sunset'])) : convertToBanglaNumber(DateFormat('hh:mm').format(DateFormat('HH:mm').parse(state.topSectionData['sunset']))),
                                      style: kStyleTextW600CW.copyWith(fontSize: 10.sp)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(clock, height: 12.h, width: 12.w),
                            SizedBox(width: 4.w),
                            CurrentTime(counter: DateTime.now())
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
        Positioned.fill(
          top: 85.h,
          left: 8,
          right: 8,
          child: const HomeScreenTopCardZone(),
        ),
      ],
    );
  }
}

class DefaultCircularProgressIndicator extends StatelessWidget {
  final double? stroke;
  const DefaultCircularProgressIndicator({
    super.key,
    this.stroke,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: kColorPrimary,
      strokeWidth: stroke ?? 5,
    );
  }
}
