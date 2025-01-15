// ignore_for_file: dead_code, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muslim_vision/controllers/services/adhan_notification/adhan_notification_setup.dart';
import 'package:muslim_vision/controllers/services/ad_mob_service.dart';

import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/firebase_push_notification/notification_service.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_banner_section.dart';

import 'package:muslim_vision/views/pages/home_screen/home_widgets/fileImages_in_home.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/prohibited_prayer_time_widget.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/ramadan_card_section.dart';
import 'package:muslim_vision/views/pages/ramadan_screen/ramadan_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../controllers/services/common_functions.dart';

import 'home_widgets/home_screen_hadith_card.dart';
import 'home_widgets/home_screen_names_of_allah_card.dart';
import 'home_widgets/home_screen_prayer_tracker_section.dart';
import 'home_widgets/home_screen_scrollable_widgets.dart';
import 'home_widgets/home_screen_top_section.dart';
import 'home_widgets/home_screen_verse_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _bannerAd;
  final utilBox = Boxes().utilsBox;
  _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
    setState(() {});
  }

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();

    _createBannerAd();
    if (utilBox.get('notification') != null) {
      notificationServices.requestNotificationPermisions();
      notificationServices.forgroundMessage();
      notificationServices.firebaseInit(context);
      notificationServices.setupInteractMessage(context);
      notificationServices.isRefreshToken();
      notificationServices.getDeviceToken().then((value) {
        debugPrint('Firebase Notificaiton token $value');
      });
    }

    //_checkNotificationPermission(); // when notification is not permit
  }

  // All flag

  bool isAddEnable = Boxes().syncBox.get('google_ad'); // google ad anable

  bool isRamadan = Boxes().syncBox.get('is_ramadan'); //is ramadan enable
  bool isBannarTop = Boxes().syncBox.get('is_top_banner_show'); //is bannar top is enable
  bool isBannarMiddle = Boxes().syncBox.get('is_middle_banner_show'); //is bannar middle is enable
  bool isBannarBottom = Boxes().syncBox.get('is_bottom_banner_show'); //is bannar bottom is enable
  // All Web link flag
  bool isRamadanWeb = Boxes().syncBox.get('ramadan_web_on'); //is ramadan web is enable
  bool isBannarWebTop = Boxes().syncBox.get('is_top_banner_web_on'); //is bannar web top is enable
  bool isBannarWebMiddle = Boxes().syncBox.get('is_middle_banner_web_on'); //is bannar web middle is enable
  bool isBannarWebBottom = Boxes().syncBox.get('is_bottom_banner_web_on'); //is bannar web bottom is enable

  // directAdd  flag
  bool isTopDirectAdd = Boxes().syncBox.get('is_top_directAD_show'); //is ditect ad Top is enable
  bool isMiddleDirectAdd = Boxes().syncBox.get('is_middle_directAD_show'); //is ditect ad Middle is enable
  bool isBottomDirectAdd = Boxes().syncBox.get('is_bottom_directAD_show'); //is ditect ad bottom is enable
  // varse and hadis is active
  bool isVerseOfTheDay = Boxes().syncBox.get('verse_of_the_day_active'); //is verse is enable
  bool isHadisOfTheDay = Boxes().syncBox.get('hedis_of_the_day_active'); //is hasis is enable

  // All web url
  String ramadanWebLink = Boxes().syncBox.get('ramadan_web_link'); //Ramadan web link
  String bannarTopWebLink = Boxes().syncBox.get('is_top_banner_web_link'); //Banner top web link
  String bannarMiddleWebLink = Boxes().syncBox.get('is_middle_banner_web_link'); //Banner middle web link
  String bannarBottomWebLink = Boxes().syncBox.get('is_bottom_banner_web_link'); //Banner bottom web link

  // All Direct Ad url
  String directAdTopWebLink = Boxes().syncBox.get('is_top_directAD_web_link'); //Direct Ad top web link
  String directAdMiddleWebLink = Boxes().syncBox.get('is_middle_directAD_web_link'); //Direct Ad middle web link
  String directAdBottomWebLink = Boxes().syncBox.get('is_bottom_directAD_web_link'); //Direct Ad bottom web link

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();
    bool isCancle = utilBox.get('isCancle') ?? false;
    if (!isCancle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkNotificationPermission();
      });
    }
    if (utilBox.get('notification') != null && utilBox.get('lat') != null&&utilBox.get('azan_notification',defaultValue: true)) {
      AdhanNotificationSetup().setNotificationIfConditionsMet(context);
    }
    // --- Clear App Cache ---
    try {
      await CommonFunctions.clearAppCacheIfDateMatches();
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) {
        CommonFunctions().ShowMessage(context, ContentType.failure, '', e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorPrimary,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HomeScreenTopSection(),
                      SizedBox(height: 8.0.h),
                      isRamadan
                          ? InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: const RamadanScreen(),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              },
                              child: const RamadanCardSection())
                          // ignore: duplicate_ignore
                          // ignore: dead_code
                          : const SizedBox.shrink(),
                      //isRamadan ? SizedBox(height: 2.0.h) : const SizedBox.shrink(),
                      const HomeScreenScrollableWidgets(),
                      SizedBox(height: 8.0.h),
                      isTopDirectAdd
                          ? StreamBuilder(
                              stream: Connectivity().onConnectivityChanged,
                              builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                                if (snapshot.hasData) {
                                  ConnectivityResult? result = snapshot.data;
                                  if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.vpn) {
                                    return Column(
                                      children: [
                                        HomeScreenBannerSection(
                                          webViewController: WebViewController()
                                            ..setJavaScriptMode(JavaScriptMode.disabled)
                                            ..loadRequest(Uri.parse(directAdTopWebLink)),
                                          width: 500.w,
                                          height: 100.h,
                                        ),
                                        SizedBox(height: 8.0.h),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            )
                          : const SizedBox.shrink(),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
                        child: Column(
                          children: [
                            const HomeScreenPrayerTrackerSection(),
                            SizedBox(height: 8.0.h),
                            const ProhibitedPrayerTimeWidget(),
                            SizedBox(height: 8.0.h),
                            isBannarTop
                                ? ShowFileImage(
                                    flag: isBannarWebTop,
                                    webLisk: bannarTopWebLink,
                                    img: 'is_top_banner_image_link',
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(height: 8.0.h),
                            isRamadan
                                ? ShowFileImage(
                                    flag: isRamadanWeb,
                                    webLisk: ramadanWebLink,
                                    img: 'ramadan_img_Link',
                                  )
                                : const SizedBox.shrink(),
                            isRamadan ? SizedBox(height: 8.0.h) : const SizedBox.shrink(),
                            isVerseOfTheDay ? const HomeScreenVerseCard() : const SizedBox.shrink(),
                            SizedBox(height: 8.0.h),
                            isHadisOfTheDay ? const HomeScreenHadithCard() : const SizedBox.shrink(),
                            SizedBox(height: 8.0.h),
                            isMiddleDirectAdd
                                ? StreamBuilder(
                                    stream: Connectivity().onConnectivityChanged,
                                    builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                                      if (snapshot.hasData) {
                                        ConnectivityResult? result = snapshot.data;
                                        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.vpn) {
                                          return Column(
                                            children: [
                                              HomeScreenBannerSection(
                                                webViewController: WebViewController()
                                                  ..setJavaScriptMode(JavaScriptMode.disabled)
                                                  ..loadRequest(Uri.parse(directAdMiddleWebLink)),
                                                width: 500.w,
                                                height: 100.h,
                                              ),
                                              SizedBox(height: 8.0.h),
                                            ],
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  )
                                : const SizedBox.shrink(),
                            isBannarMiddle
                                ? ShowFileImage(
                                    flag: isBannarWebMiddle,
                                    webLisk: bannarMiddleWebLink,
                                    img: 'is_middle_banner_image_link',
                                  )
                                : const SizedBox.shrink(),
                            isBannarMiddle ? SizedBox(height: 8.0.h) : const SizedBox.shrink(),
                            SizedBox(height: 8.0.h),
                            const HomeScreenNamesOfAllahCard(),
                            SizedBox(height: 16.0.h),
                            isBottomDirectAdd
                                ? StreamBuilder(
                                    stream: Connectivity().onConnectivityChanged,
                                    builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                                      if (snapshot.hasData) {
                                        ConnectivityResult? result = snapshot.data;
                                        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.vpn) {
                                          return Column(
                                            children: [
                                              HomeScreenBannerSection(
                                                webViewController: WebViewController()
                                                  ..setJavaScriptMode(JavaScriptMode.disabled)
                                                  ..loadRequest(Uri.parse(directAdBottomWebLink)),
                                                width: 500.w,
                                                height: 100.h,
                                              ),
                                              SizedBox(height: 8.0.h),
                                            ],
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  )
                                : const SizedBox.shrink(),
                            isBannarBottom
                                ? ShowFileImage(
                                    flag: isBannarWebBottom,
                                    webLisk: bannarBottomWebLink,
                                    img: 'is_bottom_banner_image_link',
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            isAddEnable
                ? StreamBuilder(
                    stream: Connectivity().onConnectivityChanged,
                    builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                      if (snapshot.hasData) {
                        ConnectivityResult? result = snapshot.data;
                        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.vpn) {
                          return _bannerAd == null
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: 52.h,
                                  child: AdWidget(ad: _bannerAd!),
                                );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _checkNotificationPermission() async {
    var notificationPermission = await Permission.notification.status;

    if (!notificationPermission.isGranted || utilBox.get('lat') == null) {
      _showNotificationPermissionAlert();
    }
  }

  void _showNotificationPermissionAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'turn_on_location_for_qibla_and_noti'.tr(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
          ),
          content: Text('enable_notification_permissions_note'.tr()),
          actions: <Widget>[
            Text(
              'note'.tr(),
              style: const TextStyle(color: kColorPrimary, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kColorRed)),
                    onPressed: () {
                      utilBox.put('isCancle', true);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                      child: FittedBox(
                        child: Text(
                          'cancel'.tr(),
                          style: const TextStyle(color: kColorWhite),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Handle location permission
                      if (utilBox.get('long') == null && utilBox.get('lat') == null) {
                        await CommonFunctions().processLocationPermissionMedicine(context);
                      } else {
                        CommonFunctions().ShowMessage(
                          context,
                          ContentType.warning,
                          "location_permitted".tr(),
                          "location_enabled".tr(),
                        );
                      }

                      // Handle notification permission
                      if (utilBox.get('long') != null && utilBox.get('lat') != null) {
                        if (utilBox.get('notification') == null) {
                          CommonFunctions().processNotificationPermission(context, false);
                        } else {
                          CommonFunctions().ShowMessage(
                            context,
                            ContentType.warning,
                            "notification_permitted".tr(),
                            "notification_enabled".tr(),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                      child: FittedBox(
                        child: Text(
                          'turn_on'.tr(),
                          style: const TextStyle(color: kColorWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // void _showNotificationPermissionAlert() {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('turn_on_location_for_qibla'.tr()),
  //         content: Text('enable_notification_permissions_note'.tr()),
  //         actions: <Widget>[
  //           Text(
  //             'note'.tr(),
  //             style: const TextStyle(color: kColorPrimary, fontWeight: FontWeight.w600),
  //           ),
  //           if (_isCancelVisible)
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(
  //                 'cancel'.tr(),
  //                 style: const TextStyle(color: kColorRed),
  //               ),
  //             ),
  //           TextButton(
  //             onPressed: () async {
  //               // Hide the cancel button
  //               _hideCancelButton();
  //               // Navigator.of(context).pop();
  //               if (utilBox.get('long') == null && utilBox.get('lat') == null) {
  //                 await CommonFunctions().processLocationPermission(context);
  //               } else {
  //                 CommonFunctions().ShowMessage(
  //                   context,
  //                   ContentType.warning,
  //                   "location_permitted".tr(),
  //                   "location_enabled".tr(),
  //                 );
  //               }
  //               if (utilBox.get('long') != null && utilBox.get('lat') != null) {
  //                 if (utilBox.get('notification') == null) {
  //                   CommonFunctions().processNotificationPermission(context);
  //                 } else {
  //                   CommonFunctions().ShowMessage(context, ContentType.warning, "notification_permitted".tr(), "notification_enabled".tr());
  //                 }
  //               }
  //               //  await openAppSettings(); // This will take the user to app settings
  //             },
  //             child: Text(
  //               'turn_on_notification'.tr(),
  //               style: const TextStyle(color: kColorGreen),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
