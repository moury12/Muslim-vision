// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/custom_button_widget.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/daily_muslim_screen/dailymuslim_screen.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_screen.dart';

import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_screen.dart';
import 'package:muslim_vision/views/pages/qiblah_screen/qiblah_screen.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenScrollableWidgets extends StatefulWidget {
  const HomeScreenScrollableWidgets({super.key});

  @override
  State<HomeScreenScrollableWidgets> createState() => _HomeScreenScrollableWidgetsState();
}

class _HomeScreenScrollableWidgetsState extends State<HomeScreenScrollableWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8.0.w, 8.0.w, 8.0.w, 4.0.w),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomButtonWidget(
              isPng: false,
              imageUrl: prayerBtn,
              title: 'prayer'.tr(),
              onPressed: () {
                Navigator.of(context).push(
                  CustomPageRoute(
                    child: const PrayerProcedureScreen(),
                    direction: AxisDirection.left,
                  ),
                );
              },
            ),
            SizedBox(width: 20.w),
            CustomButtonWidget(
              isPng: false,
              imageUrl: tasbeeh,
              title: 'tasbeeh'.tr(),
              onPressed: () {
                Navigator.of(context).push(
                  CustomPageRoute(
                    child: const TasbeehScreen(),
                    direction: AxisDirection.left,
                  ),
                );
              },
            ),
            SizedBox(width: 20.w),
            CustomButtonWidget(
              isPng: false,
              imageUrl: qibla,
              title: 'qibla'.tr(),
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute(
                  child: const QiblahScreen(),
                  direction: AxisDirection.left,
                ));
              },
            ),
            SizedBox(width: 20.w),
            CustomButtonWidget(
              isPng: false,
              imageUrl: nearbymusue,
              title: 'mosque'.tr(),
              onPressed: () async {
                final utilBox = Boxes().utilsBox;

                LocationPermission permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                }

                if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  await utilBox.put('lat', position.latitude);
                  await utilBox.put('long', position.longitude);
                  /*-------------------------get city name----------------------*/
                  List<Placemark>? placeMarks = await CommonFunctions().getCityName(position);
                  if (placeMarks != null) {
                    String? city = placeMarks[0].locality;

                    if (city != utilBox.get('city')) {
                      await utilBox.put('city', city);
                    }
                  }
                }

                if (await CommonFunctions().hasInternetConnection() && mounted) {
                  if (utilBox.get('lat') != null && utilBox.get('long') != null) {
                    final String url = 'https://www.google.com/maps/search/?api=1&query=mosque@${utilBox.get('lat')},${utilBox.get('long')}';
                    launchUrl(Uri.parse(url));
                  } else {
                    permission = await Geolocator.requestPermission();
                  }
                  // Navigator.of(context).push(
                  //   CustomPageRoute(
                  //     child: const NearbyMosques(),
                  //     direction: AxisDirection.left,
                  //   ),
                  // );
                } else {
                  CommonFunctions().ShowMessage(context, ContentType.warning, "no_internet_connection".tr(), "please_try_with_internet_connection".tr());
                }
              },
            ),
            SizedBox(width: 20.w),
            CustomButtonWidget(
              isPng: false,
              imageUrl: dua,
              title: 'dua'.tr(),
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute(
                  child: const DoaScreen(),
                  direction: AxisDirection.left,
                ));
              },
            ),
            /*SizedBox(width: 20.w),
            CustomButtonWidget(
              imageUrl: dua,
              title: 'Login',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const LoginDialog(),
                );
              },
            ),*/

            SizedBox(width: 20.w),
            CustomButtonWidget(
              imageUrl: daily_muslim,
              title: 'daily_muslim'.tr(),
              isPng: true,
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute(
                  child: const DailyMuslimScreen(),
                  direction: AxisDirection.left,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NearbyMosques {
  const NearbyMosques();
}
