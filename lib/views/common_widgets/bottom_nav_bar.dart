// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/views/pages/medicine_alert_screen/daily_alart_view_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../controllers/services/common_strings.dart';
import '../pages/Quran_screen/surah_names_screen.dart';
import '../pages/home_screen/home_screen.dart';
import '../pages/more_screen/more_screen.dart';
import '../pages/prayer_screen/prayer_screen.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  int index = 0;

  BottomNavBar({super.key, required this.index});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final screens = [
    const HomeScreen(),
    const SurahNamesScreen(),
    const PrayerScreen(),
    // const TasbeehScreen(),
    const DailyAlartViewScreen(),
    const MoreScreen()
  ];

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.hidden) {
  //     debugPrint('--------------------------');
  //     // App has resumed, check if location permission is now granted

  //     _checkLocationPermission();
  //     _checkNotificationPermission();
  //   }
  // }

  // void _checkNotificationPermission() async {
  //   var status = await Permission.notification.status;

  //   if (status.isGranted) {
  //     debugPrint("while in use granted");
  //     // Permission is now granted, call your function
  //   } else if (status.isDenied || status.isPermanentlyDenied) {
  //     Boxes().utilsBox.delete('notification');

  //     setState(() {});

  //     debugPrint("check Location Called");
  //     // Handle denied permissions here
  //   }
  // }

  // void _checkLocationPermission() async {
  //   var status = await Permission.location.status;

  //   if (status.isDenied || status.isPermanentlyDenied) {
  //     Boxes().utilsBox.delete('lat');
  //     Boxes().utilsBox.delete('long');

  //     CommonFunctions().processLocationPermission(context, false);

  //     debugPrint("check Location Called");
  //     // Handle denied permissions here
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.index == 0 ? true : false,
      //============> when you other pages this time you click back button then comeback HomeScreen
      onPopInvoked: (didPop) async {
        if (widget.index != 0) {
          setState(() {
            widget.index = 0;
          });
        }
      },
      child: Scaffold(
        body: screens[widget.index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent,
            height: 60.h,
            elevation: 10,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          ),
          child: NavigationBar(
            selectedIndex: widget.index,
            onDestinationSelected: (index) {
              setState(() {
                widget.index = index;
              });
            },
            destinations: [
              CustomNavigationDestination(label: 'home'.tr(), navImageUrl: homeIcon),
              CustomNavigationDestination(label: 'quran'.tr(), navImageUrl: quran),
              CustomNavigationDestination(label: 'prayer'.tr(), navImageUrl: prayer),
              // CustomNavigationDestination(
              //     label: 'tasbeeh'.tr(), navImageUrl: tasbeeh),
              CustomNavigationDestination(label: 'medicine_alert'.tr(), navImageUrl: clock),
              // CustomNavigationDestination(label: 'Medicine Alart'.tr(), navImageUrl: tasbeeh),
              CustomNavigationDestination(label: 'more'.tr(), navImageUrl: more),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNavigationDestination extends StatelessWidget {
  final String label;
  final String navImageUrl;

  const CustomNavigationDestination({required this.label, required this.navImageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const SizedBox(),
          SvgPicture.asset(
            navImageUrl,
            height: 27.h,
            width: 27.w,
            fit: BoxFit.cover,
            color: kColorGrey,
          ),
          FittedBox(
            child: Text(
              label,
              style: kStyleTextW500CG.copyWith(fontSize: 10.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
      label: label,
      selectedIcon: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const Divider(
            height: 0,
            indent: 28,
            endIndent: 28,
            color: Colors.green,
            thickness: 2.5,
          ),
          SvgPicture.asset(
            navImageUrl,
            height: 27.h,
            width: 27.w,
            fit: BoxFit.cover,
            color: kColorPrimary,
          ),
          FittedBox(
            child: Text(
              label,
              style: kStyleTextW500CP.copyWith(fontSize: 10.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}
