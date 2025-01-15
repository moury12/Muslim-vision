import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/blocs/salah_reminder_bloc/bloc/salah_reminder_bloc.dart';
import 'package:muslim_vision/blocs/settings_bloc/settings_bloc.dart';
import 'package:muslim_vision/components/feedback_button.dart';

import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/policy_screen/policy_screen.dart';
import 'package:muslim_vision/views/pages/settings_screen/custom_switch_widget.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common_widgets/coming_soon_screen.dart';
import '../prayer_screen/prayer_notification_screen/prayer_notification_screen.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  bool? isMed;
  SettingScreen({this.isMed, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final utilBox = Boxes().utilsBox;
  SettingsBloc settingsBloc = SettingsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar(
      //   'Settings',
      //   true,
      //   [],
      //   kStyleTextW600CW.copyWith(fontSize: 14.sp),
      //   context,
      //   () {
      //     Navigator.pop(context);
      //   },
      // ),
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: kStyleTextW600CW.copyWith(
              fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            color: kColorBackground,
            surfaceTintColor: Colors.white,
            icon: const Icon(
              Icons.language,
              color: kColorWhite,
            ),

            //padding: const EdgeInsets.all(8),
            itemBuilder: (_) => [
              PopupMenuItem(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: CheckboxListTile(
                  activeColor: kColorPrimary,
                  title: const Text('English'),
                  value: context.locale.toString() == 'en',
                  onChanged: (value) {
                    context.setLocale(const Locale('en'));
                    //setState(() {});
                    //Navigator.of(context).pop();

                    Navigator.pushAndRemoveUntil(
                        context,
                        CustomPageRoute(
                          child: BottomNavBar(
                            index: 4,
                          ),
                          direction: AxisDirection.left,
                        ),
                        (route) => false);
                  },
                ),
              ),
              PopupMenuItem(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: CheckboxListTile(
                  title: const Text('Bangla'),
                  activeColor: kColorPrimary,
                  value: context.locale.toString() == 'bn',
                  onChanged: (value) {
                    context.setLocale(const Locale('bn'));
                    //setState(() {});
                    //Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CustomPageRoute(
                          child: BottomNavBar(
                            index: 4,
                          ),
                          direction: AxisDirection.left,
                        ),
                        (route) => false);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('profile'.tr(),
                      style: kStyleTextW700CP.copyWith(fontSize: 16.sp)),
                  ListTile(
                    leading: const Icon(
                      Icons.account_circle_rounded,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "signup_or_login".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: const ComingSoonScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('feature_settings'.tr(),
                      style: kStyleTextW700CP.copyWith(fontSize: 16.sp)),
                  ListTile(
                    leading: const Icon(
                      Icons.watch_later_outlined,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "prayer_alarms".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CustomPageRoute(
                            child: const PrayerNotificationScreen(),
                            direction: AxisDirection.left,
                          ),
                          (route) => true);
                    },
                  ),
                  BlocBuilder<SettingsBloc, SettingsState>(
                    bloc: settingsBloc,
                    builder: (context, state) {
                      bool isLoading = state is SettingsLoadingState;
                      if (state is AzanNotificationState || isLoading) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            prayer,
                            height: 15.h,
                          ),
                          title: Text(
                            state is AzanNotificationState&&  state.azanStatus? "trun_azan_off".tr():"trun_azan_on".tr(),
                            style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                          ),
                          trailing: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap:isLoading?null: () {

                                settingsBloc.add(TurnAzanOffEvent(context,
                                    toggleValue:
                                    state is AzanNotificationState&&  state.azanStatus ? false : true));
                              context.read<SalahReminderBloc>().add(SalahReminderLoadedEvent());
                                },
                              child: CustomSwitch(
                                isOn: state is AzanNotificationState&& state.azanStatus, isloading: isLoading,
                              )),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -2),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),

                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("permission_settings".tr(),
                      style: kStyleTextW700CP.copyWith(fontSize: 16.sp)),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on_rounded,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "enable_location".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () async {
                      bool isMed = widget.isMed ?? false;
                      if (utilBox.get('long') == null &&
                          utilBox.get('lat') == null) {
                        await CommonFunctions()
                            .processLocationPermission(context, isMed);
                      } else {
                        CommonFunctions().ShowMessage(
                          context,
                          ContentType.warning,
                          "location_permitted".tr(),
                          "location_enabled".tr(),
                        );
                      }


                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.notification_important,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "turn_on_notification".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () async {
                      bool isMed = widget.isMed ?? false;
                      if (utilBox.get('long') != null &&
                          utilBox.get('lat') != null) {
                        if (utilBox.get('notification') == null) {
                          CommonFunctions()
                              .processNotificationPermission(context, isMed);
                        } else {
                          CommonFunctions().ShowMessage(
                              context,
                              ContentType.warning,
                              "notification_permitted".tr(),
                              "notification_enabled".tr());
                        }
                      } else {
                        CommonFunctions().ShowMessage(
                            context,
                            ContentType.warning,
                            "turn_on_GPS_location".tr(),
                            "turn_on_location_to_use_the_qibla_compass_feature_so_you_can_perform_your_prayer_in_the_right_direction"
                                .tr());
                      }
                      // if (await CommonFunctions().hasInternetConnection() &&
                      //     context.mounted) {
                      //   Navigator.of(context).push(
                      //     CustomPageRoute(
                      //       child: PolicyScreen(
                      //         webViewController: WebViewController()
                      //           ..setBackgroundColor(kColorWhite)
                      //           ..setJavaScriptMode(JavaScriptMode.disabled)
                      //           ..loadRequest(Uri.parse(
                      //               "https://muslim-vision.com/credits/")),
                      //         title: "Credits",
                      //       ),
                      //       direction: AxisDirection.left,
                      //     ),
                      //   );
                      // } else {
                      //   CommonFunctions().ShowMessage(
                      //       context,
                      //       ContentType.warning,
                      //       "no_internet_connection".tr(),
                      //       "Please try With Internet Connection");
                      //   // CommonFunctions().ShowMessage(context, ContentType.warning, "No Internet Connection", "Please try With Internet Connection");
                      // }
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('legal'.tr(),
                      style: kStyleTextW700CP.copyWith(fontSize: 16.sp)),
                  ListTile(
                    leading: const Icon(
                      Icons.policy_rounded,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "policies".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () async {
                      if (await CommonFunctions().hasInternetConnection() &&
                          context.mounted) {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: PolicyScreen(
                              webViewController: WebViewController()
                                ..setBackgroundColor(kColorWhite)
                                ..setJavaScriptMode(JavaScriptMode.disabled)
                                ..loadRequest(Uri.parse(
                                    "https://muslim-vision.com/privacy-policy/#")),
                              title: "Privacy Policy",
                            ),
                            direction: AxisDirection.left,
                          ),
                        );
                      } else {
                        CommonFunctions().ShowMessage(
                            context,
                            ContentType.warning,
                            "no_internet_connection".tr(),
                            "Please try With Internet Connection");
                        CommonFunctions().ShowMessage(
                            context,
                            ContentType.warning,
                            "No Internet Connection",
                            "Please try With Internet Connection");
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.account_tree,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "credits".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () async {
                      if (await CommonFunctions().hasInternetConnection() &&
                          context.mounted) {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: PolicyScreen(
                              webViewController: WebViewController()
                                ..setBackgroundColor(kColorWhite)
                                ..setJavaScriptMode(JavaScriptMode.disabled)
                                ..loadRequest(Uri.parse(
                                    "https://muslim-vision.com/credits/")),
                              title: "Credits",
                            ),
                            direction: AxisDirection.left,
                          ),
                        );
                      } else {
                        CommonFunctions().ShowMessage(
                            context,
                            ContentType.warning,
                            "no_internet_connection".tr(),
                            "Please try With Internet Connection");
                        // CommonFunctions().ShowMessage(context, ContentType.warning, "No Internet Connection", "Please try With Internet Connection");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('social'.tr(),
                      style: kStyleTextW700CP.copyWith(fontSize: 16.sp)),
                  ListTile(
                    leading: const Icon(
                      Icons.groups,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "send_muslim_vision_to_a_friend".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () async {
                      // Navigator.of(context).push(
                      //   CustomPageRoute(
                      //     child: const ComingSoonScreen(),
                      //     direction: AxisDirection.left,
                      //   ),
                      // );
                      await Share.shareWithResult(
                        "https://play.google.com/store/apps/details?id=com.muslim_vision",
                      );
                    },
                  ),
                 FeedBackButton(),
                  ListTile(
                    leading: const Icon(
                      Icons.facebook,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "facebook".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: const ComingSoonScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.link_outlined,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "twitter".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: const ComingSoonScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.public,
                      color: kColorPrimary,
                    ),
                    title: Text(
                      "website".tr(),
                      style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kColorPrimary,
                      size: 15.h,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: const ComingSoonScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
