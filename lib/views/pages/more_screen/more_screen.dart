import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/more_screen_bloc/bloc/more_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_button_widget.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/five_pillars_screen/five_pillars_of_islam.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_screen.dart';
import 'package:muslim_vision/views/pages/hajj_umrah_screen/hajj_umrah_screen.dart';
import 'package:muslim_vision/views/pages/live_qaba/live_qaba_screen.dart';
import 'package:muslim_vision/views/pages/names_screen/name_screen.dart';
import 'package:muslim_vision/views/pages/qurbani_screen/qurbani_screen.dart';
import 'package:muslim_vision/views/pages/ramadan_screen/ramadan_screen.dart';
import 'package:muslim_vision/views/pages/settings_screen/setting_screen.dart';
import 'package:muslim_vision/views/pages/zakat_screen/zakat_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //
  // bool isMoreScreenAdEnabled = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoreScreenBloc>(context).add(MoreScreenLoadEvent());

    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    //
    // final isAdded = Boxes().isAdded;
    // isMoreScreenAdEnabled = isAdded.get('isMoreScreenAdEnabled');
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //     await _updateConnectionStatus(result);
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return;
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }

  // bool isConnected() {
  //   return _connectionStatus == ConnectivityResult.mobile ||
  //       _connectionStatus == ConnectivityResult.wifi ||
  //       _connectionStatus == ConnectivityResult.ethernet ||
  //       _connectionStatus == ConnectivityResult.vpn;
  // }

  @override
  Widget build(BuildContext context) {
    //bool isAddEnable = Boxes().syncBox.get('is_add_enable');
    //String isAddUrl3 = Boxes().syncBox.get('is_add_url3');
    return Scaffold(
      appBar: customAppBar(
          "more_options".tr(),
          false,
          [
            //IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
          kStyleTextW500CW.copyWith(fontSize: 14.sp),
          context, () {
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute<void>(builder: (BuildContext context) => BottomNavBar(index: 0)), (route) => false);
        Navigator.pushAndRemoveUntil(
            context,
            CustomPageRoute(
              child: BottomNavBar(
                index: 0,
              ),
              direction: AxisDirection.right,
            ),
            (route) => false);
      }),
      body: Padding(
        padding: const EdgeInsets.all(8).r,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0).r,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: calculator,
                              title: 'jakat_calculator'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(CustomPageRoute(
                                  child: const ZakatCalculateScreen(),
                                  direction: AxisDirection.left,
                                ));
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: hajj_umrah1,
                              title: 'hajj_umrah'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: const HajjUmrahScreen(),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: live_qaba,
                              title: 'live_qaba'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(CustomPageRoute(
                                  child: const LiveQabaScreen(),
                                  direction: AxisDirection.left,
                                ));
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: qurbani,
                              title: 'qurbani'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: const QurbaniScreen(),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: ramadan,
                              title: 'ramadan'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: const RamadanScreen(),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: five_pillars,
                              title: 'five_pillars'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: const FivePillarsOfIslamWidgets(),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                              isPng: false,
                              imageUrl: names,
                              title: 'names'.tr(),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: const NameScreen(),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomButtonWidget(
                            isPng: false,
                            imageUrl: wallpaper,
                            title: 'greeting_messages'.tr(),
                            onPressed: () {
                              Navigator.of(context).push(
                                CustomPageRoute(
                                  child: const GreetingMessages(),
                                  direction: AxisDirection.left,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Flexible(
                        //   fit: FlexFit.tight,
                        //   child: CustomButtonWidget(
                        //       isPng: false,
                        //       imageUrl: wallpaper,
                        //       title: "medicine_alert".tr(),
                        //       onPressed: () {
                        //         Navigator.of(context).push(
                        //           CustomPageRoute(
                        //             child: const DailyAlartViewScreen(),
                        //             direction: AxisDirection.left,
                        //           ),
                        //         );
                        //       }),
                        // ),
                        // Flexible(
                        //   fit: FlexFit.tight,
                        //   child: CustomButtonWidget(imageUrl: azan, title: 'Azan', onPressed: () {}),
                        // ),
                        // Flexible(
                        //   fit: FlexFit.tight,
                        //   child: CustomButtonWidget(
                        //     imageUrl: calender,
                        //     title: 'Calender',
                        //     onPressed: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            /*Card(
              elevation: 0,
              child: ListTile(
                leading: Text(
                  "Profile",
                  style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kColorPrimary,
                  size: 15.h,
                ),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
              ),
            ),*/
            Card(
              elevation: 0,
              child: ListTile(
                leading: Text(
                  "settings".tr(),
                  style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kColorPrimary,
                  size: 15.h,
                ),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                onTap: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child: SettingScreen(
                        isMed: false,
                      ),
                      direction: AxisDirection.left,
                    ),
                  );
                },
              ),
            ),
            // Card(
            //   elevation: 0,
            //   child: ListTile(
            //     leading: Text(
            //       "about".tr(),
            //       style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
            //     ),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios,
            //       color: kColorPrimary,
            //       size: 15.h,
            //     ),
            //     visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            //   ),
            // ),
            // SizedBox(height: 8.h),
            // isMoreScreenAdEnabled && isConnected()
            //     ? Column(
            //         children: [
            //           SizedBox(height: 8.0.h),
            //           HomeScreenBannerSection(
            //             webViewController: WebViewController()
            //               ..setJavaScriptMode(JavaScriptMode.disabled)
            //               ..loadRequest(
            //                   Uri.parse("https://www.prothomalo.com/")),
            //             width: 500,
            //             height: 88,
            //           ),
            //         ],
            //       )
            //     : SizedBox(),
            SizedBox(height: 8.0.h),
            BlocBuilder<MoreScreenBloc, MoreScreenState>(
              builder: (context, state) {
                if (state is MoreScreenLoadedState) {
                  return Center(
                    child: Text(
                      "Version ${state.version}",
                      style: kStyleTextW400CG.copyWith(fontSize: 9.sp),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            // SizedBox(height: 8.0.h),
            // isAddEnable
            //     ? StreamBuilder(
            //         stream: Connectivity().onConnectivityChanged,
            //         builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            //           if (snapshot.hasData) {
            //             ConnectivityResult? result = snapshot.data;
            //             if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.vpn) {
            //               return Column(
            //                 children: [
            //                   HomeScreenBannerSection(
            //                     webViewController: WebViewController()
            //                       ..setJavaScriptMode(JavaScriptMode.disabled)
            //                       ..loadRequest(Uri.parse("https://www.prothomalo.com/")),
            //                     width: 500.w,
            //                     height: 100.h,
            //                   ),
            //                   SizedBox(height: 8.0.h),
            //                 ],
            //               );
            //             } else {
            //               return const SizedBox.shrink();
            //             }
            //           } else {
            //             return const SizedBox.shrink();
            //           }
            //         },
            //       )
            //     : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
