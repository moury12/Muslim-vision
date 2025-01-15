// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_vision/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  // List<String> messages = [
  //   "syncing_for_the_first_time".tr(),
  //   "slow_internet_please_wait".tr(),
  //   "please_wait".tr(),
  //   "hold_up_almost_done".tr(),
  //   "just_a_moment".tr()
  // ];

  // int currentMessageIndex = 0;
  // Timer? timer;
  // @override
  // void initState() {

  //   timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
  //     setState(() {
  //       // Cycle through the messages
  //       currentMessageIndex = (currentMessageIndex + 1) % messages.length;
  //     });
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SplashScreenSyncState) {
            return Stack(
              children: [
                Container(
                  height: double.maxFinite,
                  width: double.infinity,
                  decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff16bf7e), Color(0xff0a3c26)])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/json/sync_data.json',
                      ),
                      Padding(
                          padding: EdgeInsets.all(12.0.sp),
                          child: Text(
                            state.message,
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          )),
                      //   TypewriterText(
                      //     text: state.message,
                      //     duration: const Duration(seconds: 2),
                      //     textStyle:
                      //         TextStyle(fontSize: 16.sp, color: kColorWhite),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Positioned(bottom: 0, left: 0, right: 0, child: SvgPicture.asset(mousqeShade, fit: BoxFit.fitWidth, color: Colors.black.withOpacity(1)))
              ],
            );
          } else if (state is SplashScreenErrorState) {
            return Stack(
              children: [
                Container(
                  height: double.maxFinite,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff16bf7e), Color(0xff0a3c26)])),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                    child: Text(
                      state.errorMsg,
                      style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                Positioned(bottom: 0, left: 0, right: 0, child: SvgPicture.asset(mousqeShade, fit: BoxFit.fitWidth, color: Colors.black.withOpacity(1)))
              ],
            );
          } else if (state is SplashScreenMessageState) {
            return StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                if (snapshot.hasData) {
                  ConnectivityResult? result = snapshot.data;
                  if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.vpn) {
                    BlocProvider.of<SplashScreenBloc>(context).add(SplashScreenLoadedEvent());
                    return Stack(
                      children: [
                        Container(
                          height: double.maxFinite,
                          width: double.infinity,
                          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff16bf7e), Color(0xff0a3c26)])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/json/sync_data.json',
                              ),
                              Padding(
                                  padding: EdgeInsets.all(12.0.sp),
                                  child: Text(
                                    state.msg,
                                    style: const TextStyle(fontSize: 18, color: Colors.white),
                                  )),
                              //   TypewriterText(
                              //     text: state.message,
                              //     duration: const Duration(seconds: 2),
                              //     textStyle:
                              //         TextStyle(fontSize: 16.sp, color: kColorWhite),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Positioned(bottom: 0, left: 0, right: 0, child: SvgPicture.asset(mousqeShade, fit: BoxFit.fitWidth, color: Colors.black.withOpacity(1)))
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        Container(
                          height: double.maxFinite,
                          width: double.infinity,
                          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromARGB(255, 191, 33, 22), Color(0xff0a3c26)])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/json/sync_data.json',
                              ),
                              Padding(
                                  padding: EdgeInsets.all(12.0.sp),
                                  child: Column(
                                    children: [
                                      Text(
                                        "no_internet_connection".tr(),
                                        style: const TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        "please_try_with_internet_connection".tr(),
                                        style: const TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  )),
                              //   TypewriterText(
                              //     text: state.message,
                              //     duration: const Duration(seconds: 2),
                              //     textStyle:
                              //         TextStyle(fontSize: 16.sp, color: kColorWhite),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Positioned(bottom: 0, left: 0, right: 0, child: SvgPicture.asset(mousqeShade, fit: BoxFit.fitWidth, color: Colors.black.withOpacity(1)))
                      ],
                    );
                  }
                } else {
                  return Stack(
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: double.infinity,
                        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromARGB(255, 191, 33, 22), Color(0xff0a3c26)])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/json/sync_data.json',
                            ),
                            Padding(
                                padding: EdgeInsets.all(12.0.sp),
                                child: Column(
                                  children: [
                                    Text(
                                      "no_internet_connection".tr(),
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      "please_try_with_internet_connection".tr(),
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                )),
                            //   TypewriterText(
                            //     text: state.message,
                            //     duration: const Duration(seconds: 2),
                            //     textStyle:
                            //         TextStyle(fontSize: 16.sp, color: kColorWhite),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(bottom: 0, left: 0, right: 0, child: SvgPicture.asset(mousqeShade, fit: BoxFit.fitWidth, color: Colors.black.withOpacity(1)))
                    ],
                  );
                }
              },
            );
          }

          return Stack(
            children: [
              Container(
                height: double.maxFinite,
                width: double.infinity,
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff16bf7e), Color(0xff0a3c26)])),
              ),
              Positioned(bottom: 0, left: 0, right: 0, child: SvgPicture.asset(mousqeShade, fit: BoxFit.fitWidth, color: Colors.black.withOpacity(1)))
            ],
          );
        },
      ),
    );
  }
}
