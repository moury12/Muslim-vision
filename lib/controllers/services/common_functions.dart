// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:adhan/adhan.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:muslim_vision/controllers/services/image_download_show_delete_in_local.dart';
import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';

import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/utils.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../database/boxes.dart';
import 'package:geolocator/geolocator.dart' as geo;

import 'adhan_notification/adhan_notification_setup.dart';

class CommonFunctions {
  final utilBox = Boxes().utilsBox;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if GPS is not turned on and utilsBox is not empty then return lat, long from hive
    if (!serviceEnabled) {
      final utilBox = Boxes().utilsBox;
      if (utilBox.keys.isNotEmpty) {
        double long = double.parse(utilBox.get('long').toString());
        double lat = double.parse(utilBox.get('lat').toString());
        Position pos = Position(longitude: long, latitude: lat, timestamp: DateTime.now(), accuracy: 0.0, altitude: 0.0, altitudeAccuracy: 0.0, heading: 0.0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0);
        return pos;
      }
    }
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<List<Placemark>?> getCityName(Position pos) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      return placeMarks;
    } catch (err) {
      return null;
    }
  }

  String cleanText(String text) {
    return text
        .replaceAll(",", " ") // Replace commas with spaces
        .replaceAll("[", "") // Remove opening bracket
        .replaceAll("]", "");
  }

  Future<void> shareImage(GlobalKey imageKey) async {
    Uint8List bytes = await Utils.capture(imageKey);
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/MuslimVision.png';
    File(path).writeAsBytesSync(bytes);
    final result = await Share.shareXFiles([XFile(path)], text: 'https://play.google.com/store/apps/details?id=com.muslim_vision');
    if (result.status == ShareResultStatus.success) {
      debugPrint('Thank you for sharing the picture!');
    }
  }

  Future<void> shareOnlineImage(File url) async {
    try {
      // Sharing the file
      final result = await Share.shareXFiles([XFile(url.path)], text: 'https://play.google.com/store/apps/details?id=com.muslim_vision');
      if (result.status == ShareResultStatus.success) {
        debugPrint('Thank you for sharing the picture!');
      } else {
        debugPrint('Failed to share the picture.');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }

  String getVerseEndSymbol(int verseNumber, {bool arabicNumeral = true}) {
    var arabicNumeric = '';
    var digits = verseNumber.toString().split("").toList();

    if (!arabicNumeral) return '\u06dd${verseNumber.toString()}';

    const Map arabicNumbers = {"0": "٠", "1": "۱", "2": "۲", "3": "۳", "4": "٤", "5": "٥", "6": "٦", "7": "۷", "8": "۸", "9": "۹"};

    for (var e in digits) {
      arabicNumeric += arabicNumbers[e];
    }

    return '\u06DD$arabicNumeric';
  }

  static PrayerTimes getPrayerTime(double lat, double long, DateTime date) {
    final myCoordinates = Coordinates(lat, long);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    PrayerTimes prayerTimes = PrayerTimes(myCoordinates, DateComponents(date.year, date.month, date.day), params);
    return prayerTimes;
  }

// Play Audio

  Future<void> playSound(String url) async {
    AudioPlayer audioPlayer = AudioPlayer();
//  audioPlayer.pause();

    await audioPlayer.play(AssetSource(url));
  }

  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await head(Uri.parse('https://www.google.com'));
        return response.statusCode == 200;
      } else {
        return false;
      }
    } on SocketException {
      // Handle socket exceptions (e.g., device not connected to internet)
      return false;
    } on PlatformException {
      // Handle platform exceptions (e.g., network issues or permission problems)
      return false;
    } catch (e) {
      // Handle unexpected exceptions
      debugPrint('Error checking internet connectivity: $e');
      return false;
    }
  }

  Future<void> setSyncDataInHive(Map<dynamic, dynamic>? syncData) async {
    final syncBox = Boxes().syncBox;

    log(syncData.toString());
    try {
      if (syncBox.isNotEmpty) {
        if (DateTime.parse(syncBox.get('last-sync')).isBefore(DateTime.parse(syncData!['contentUpdate']['latest_updated_date']))) {
          for (var e in syncData['contentUpdate']['hive_box']) {
            await Hive.box('$e').clear();
          }
          await syncBox.put('last-sync', syncData['contentUpdate']['latest_updated_date']);
        }
      } else {
        await syncBox.put('last-sync', syncData!['contentUpdate']['latest_updated_date']);
      }

      /// ramadan section
      await syncBox.put("is_ramadan", syncData['ramadan_greetings'][0]['is_ramadan']);
      // await syncBox.put("ramadan-img-url", syncData['ramadan_greetings'][0]['image_link']);
      await syncBox.put("ramadan_web_on", syncData['ramadan_greetings'][0]['web_on']);
      await syncBox.put("ramadan_web_link", syncData['ramadan_greetings'][0]['web_link']);

      ///banner section top
      await syncBox.put('is_top_banner_show', syncData['banner']['Top']['flag']);
      await syncBox.put('is_top_banner_type', syncData['banner']['Top']['type']);
      // await syncBox.put('is-top-banner-image_link', syncData['banner']['Top']['image_link']);
      await syncBox.put('is_top_banner_web_on', syncData['banner']['Top']['web_on']);
      await syncBox.put('is_top_banner_web_link', syncData['banner']['Top']['web_link']);

      ///banner section middle
      await syncBox.put('is_middle_banner_show', syncData['banner']['Middle']['flag']);
      await syncBox.put('is_middle_banner_type', syncData['banner']['Middle']['type']);
      // await syncBox.put('is-middle-banner-image_link', syncData['banner']['Middle']['image_link']);
      await syncBox.put('is_middle_banner_web_on', syncData['banner']['Middle']['web_on']);
      await syncBox.put('is_middle_banner_web_link', syncData['banner']['Middle']['web_link']);

      ///banner section bottom
      await syncBox.put('is_bottom_banner_show', syncData['banner']['Bottom']['flag']);
      await syncBox.put('is_bottom_banner_type', syncData['banner']['Bottom']['type']);
      // await syncBox.put('is-bottom-banner-image_link', syncData['banner']['Bottom']['image_link']);
      await syncBox.put('is_bottom_banner_web_on', syncData['banner']['Bottom']['web_on']);
      await syncBox.put('is_bottom_banner_web_link', syncData['banner']['Bottom']['web_link']);

      ///Ad section top

      await syncBox.put('is_top_directAD_show', syncData['directAD']['Top']['flag']);
      await syncBox.put('is_top_directAD_type', syncData['directAD']['Top']['type']);
      await syncBox.put('is_top_directAD_web_link', syncData['directAD']['Top']['web_link']);

      ///Ad section middle

      await syncBox.put('is_middle_directAD_show', syncData['directAD']['Middle']['flag']);
      await syncBox.put('is_middle_directAD_type', syncData['directAD']['Middle']['type']);
      await syncBox.put('is_middle_directAD_web_link', syncData['directAD']['Middle']['web_link']);

      ///Ad section Bottom

      await syncBox.put('is_bottom_directAD_show', syncData['directAD']['Bottom']['flag']);
      await syncBox.put('is_bottom_directAD_type', syncData['directAD']['Bottom']['type']);
      await syncBox.put('is_bottom_directAD_web_link', syncData['directAD']['Bottom']['web_link']);

      ///verse-of-the-day section

      await syncBox.put('verse_of_the_day', syncData['content']['verse-of-the-day']['content_text']);
      await syncBox.put('verse_of_the_day_active', syncData['content']['verse-of-the-day']['active']);

      ///hedis-of-the-day section
      await syncBox.put('hedis_of_the_day', syncData['content']['hedis-of-the-day']['content_text']);
      await syncBox.put('hedis_of_the_day_active', syncData['content']['hedis-of-the-day']['active']);

      // youtube neaybymasjid appversion
      await syncBox.put('nearbymasjid', syncData['nearbymasjid']);
      await syncBox.put('app_version', syncData['app_version']);
      await syncBox.put('youtube_player_id', syncData['youtube_player_id']);
      await syncBox.put('google_ad', syncData['google_ad']);

      // download Img in local

      if (syncData['ramadan_greetings'][0]['is_ramadan']) {
        await WorkInLoaclDir().downloadAndSaveImage(syncData['ramadan_greetings'][0]['image_link'], 'ramadan_img_Link');
      }
      if (syncData['banner']['Top']['flag']) {
        await WorkInLoaclDir().downloadAndSaveImage(syncData['banner']['Top']['image_link'], 'is_top_banner_image_link');
      }
      if (syncData['banner']['Middle']['flag']) {
        await WorkInLoaclDir().downloadAndSaveImage(syncData['banner']['Middle']['image_link'], 'is_middle_banner_image_link');
      }

      if (syncData['banner']['Bottom']['flag']) {
        await WorkInLoaclDir().downloadAndSaveImage(syncData['banner']['Bottom']['image_link'], 'is_bottom_banner_image_link');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static bool isAllBoxEmpty() {
    final procedureBox = Boxes().procedureBox;
    final dhikrBox = Boxes().tasbeehBox;
    final namesOfAllahBox = Boxes().namesOfAllahBox;
    final doaBox = Boxes().doaBox;
    final greetingBox = Boxes().greetingsBox;
    final fivePilarOfIslam = Boxes().fivePillarsDataBox;
    final namesDataBox = Boxes().namesDataBox;
    final qurbaniDataBox = Boxes().qurbaniDataBox;

    if (procedureBox.isNotEmpty && dhikrBox.isNotEmpty && namesOfAllahBox.isNotEmpty && doaBox.isNotEmpty && greetingBox.isNotEmpty && fivePilarOfIslam.isNotEmpty && namesDataBox.isNotEmpty && qurbaniDataBox.isNotEmpty) {
      return false;
    }

    return true;
  }

  bool isWatkTime(String waktTime, DateTime selectDate) {
    DateTime currentTime = DateTime.now();
    // print((currentTime.isAfter(convertWaktTimeWithDate(selectDate, waktTime))));
    if (currentTime.isAfter(convertWaktTimeWithDate(selectDate, waktTime))) {
      return true;
    } else {
      return false; //will be false
    }
  }

  DateTime convertWaktTimeWithDate(DateTime selectDate, String waktTime) {
    // Splitting the dynamicTime string to get hours, minutes, and AM/PM indicator
    List<String> timeParts = waktTime.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1].split(' ')[0]);
    String period = timeParts[1].split(' ')[1].toLowerCase();

    // Adjusting hours based on the period (AM or PM)
    if (period == "pm" && hours < 12) {
      hours += 12;
    } else if (period == "am" && hours == 12) {
      hours = 0;
    }

    // Creating a new DateTime object with the current date and dynamic time
    DateTime newDateTime = DateTime(selectDate.year, selectDate.month, selectDate.day, hours, minutes);

    return newDateTime;
  }

  // ignore: non_constant_identifier_names
  void ShowMessage(BuildContext context, ContentType type, String title, subtitle) {
    final snackBar = aweSomeSnackBar(
      title: title,
      subTitle: subtitle,
      duration: 1500,
      contentType: type,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  Future<String> getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    var deviceToken = await _firebaseMessage.getToken();
    log('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   $deviceToken   xxxxxxxxxx');

    return deviceToken.toString();
  }
  // Future<String> getAndroidID() async {
  //   const androidIdPlugin = AndroidId();
  //   String androidId;
  //   try {
  //     androidId = await androidIdPlugin.getId() ?? 'Unknown ID';
  //     debugPrint(androidId);
  //   } on PlatformException {
  //     androidId = 'Failed to get Android ID.';
  //   }

  //   return androidId.toString();
  // }

  Future<void> preloadedSVGs(List<String> assetsSvgImagePath) async {
    for (final element in assetsSvgImagePath) {
      final loader = SvgAssetLoader(element);
      await svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  Future<void> preloadedVecs(List<String> assetsVecImagePath) async {
    for (final element in assetsVecImagePath) {
      final loader = AssetBytesLoader(element);
      await svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  processNotificationPermission(BuildContext context, bool isMed) async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted && context.mounted && Boxes().utilsBox.get('azan_notification', defaultValue: true)) {
      await utilBox.put('notification', 'approved');
      AdhanNotificationSetup().setNotificationIfConditionsMet(context);
      CommonFunctions().ShowMessage(context, ContentType.success, "notification_have_enabled".tr(), "alarm_set_for_next_7_days".tr());
      isMed
          ? Navigator.pop(context)
          : Navigator.pushAndRemoveUntil(
              context,
              CustomPageRoute(
                child: BottomNavBar(index: 0),
                direction: AxisDirection.left,
              ),
              (route) => false,
            );
      // BlocProvider.of<SplashScreenBloc>(context).add(SplashScreenLoadedEvent());
      return;
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(
            child: BottomNavBar(index: 0),
            direction: AxisDirection.left,
          ),
          (route) => false,
        );
        // Navigator.of(context).popUntil((route) => route.isFirst);
        openNotificationPermissionDialog(context);
      }
    }
  }

  medicineNotificationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted && context.mounted) {
      await utilBox.put('notification', 'approved');
      // AdhanNotificationSetup().setNotificationIfConditionsMet(context);

      return;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        openNotificationPermissionDialog(context);
      }
    }
  }

  openNotificationPermissionDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('notification_permission_required'.tr()),
        content: Text('enable_notification_permissions'.tr()),
        actions: [
          TextButton(
            onPressed: () async {
              openAppSettings();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Future<String> arabicDateTime() async {
    DateTime date = DateTime.now().subtract(const Duration(days: 1));
    String todayDateHijri = HijriCalendar.fromDate(date).toFormat('dd MMMM yyyy');
    return todayDateHijri;
  }

  static Future<void> clearAppCacheIfDateMatches() async {
    final quranBox = Boxes().quranBox;
    try {
      if (!quranBox.containsKey('cacheClearDate')) {
        await quranBox.put('cacheClearDate', DateTime.now().toString());
        return;
      }
      final today = DateTime.now();
      final cacheClearStartDate = DateTime.parse(quranBox.get('cacheClearDate'));
      final cacheClearEndDate = cacheClearStartDate.add(const Duration(days: 7));
      final shouldClearCache = !(today.isAfter(cacheClearStartDate) && today.isBefore(cacheClearEndDate)); // Not In Between
      if (shouldClearCache) {
        if (!kDebugMode) {
          await quranBox.put('cacheClearDate', DateTime.now().toString());
        }
        var appDir = (await getTemporaryDirectory()).path;
        await Directory(appDir).delete(recursive: true);
        await quranBox.put('cacheClearDate', DateTime.now().toString());
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to clear app cache: $e');
    }
  }

  processLocationPermission(BuildContext context, bool isMed) async {
    try {
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // If location services are not enabled, show a dialog
        _showGPSDialog(context);
        return;
      }

      geo.Position currentPosition = await CommonFunctions().determinePosition();

      await utilBox.put('lat', currentPosition.latitude);
      await utilBox.put('long', currentPosition.longitude);

      debugPrint(currentPosition.toString());

      /*-------------------------get city name----------------------*/
      List<Placemark>? placeMarks = await CommonFunctions().getCityName(currentPosition);
      if (placeMarks != null) {
        String? city = placeMarks[0].locality;

        if (city != utilBox.get('city')) {
          await utilBox.put('city', city);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    var status = await Permission.location.status;
    // if (context.mounted) {
    //   Navigator.pop(context);
    // }
    if (status.isGranted && context.mounted && utilBox.isNotEmpty) {
      // Navigate without popping previous routes
      isMed
          ? null
          : Navigator.pushAndRemoveUntil(
              context,
              CustomPageRoute(
                child: BottomNavBar(index: 0),
                direction: AxisDirection.left,
              ),
              (route) => false,
            );
    } else if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        await openPermissionDialog(context);
        return;
      }
    }

    if (utilBox.isEmpty) {
      openGPSDialog(context);
    }
  }

  processLocationPermissionMedicine(BuildContext context) async {
    try {
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // If location services are not enabled, show a dialog
        _showGPSDialog(context);
        return;
      }

      geo.Position currentPosition = await CommonFunctions().determinePosition();

      await utilBox.put('lat', currentPosition.latitude);
      await utilBox.put('long', currentPosition.longitude);

      debugPrint(currentPosition.toString());

      /*-------------------------get city name----------------------*/
      List<Placemark>? placeMarks = await CommonFunctions().getCityName(currentPosition);
      if (placeMarks != null) {
        String? city = placeMarks[0].locality;

        if (city != utilBox.get('city')) {
          await utilBox.put('city', city);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    var status = await Permission.location.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        await openPermissionDialog(context);
        return;
      }
    }

    if (utilBox.isEmpty) {
      openGPSDialog(context);
    }
  }

  openPermissionDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text('Location Permission Required'),
          content: RichText(
            text: const TextSpan(
              text: 'Please enable location permissions in the device settings, specifically ',
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: 'Allow only while using the app',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await openAppSettings();

                Navigator.pushAndRemoveUntil(
                  context,
                  CustomPageRoute(
                    child: BottomNavBar(index: 0),
                    direction: AxisDirection.left,
                  ),
                  (route) => false,
                ); // Close dialog after settings
              },
              child: const Text(
                'Settings',
                style: TextStyle(color: kColorPrimary),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _showGPSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Enable GPS'),
        content: const Text('Location services are disabled. Please enable GPS to get your location.'),
        actions: [
          TextButton(
            onPressed: () async {
              // Open location settings for the user to enable GPS manually
              await geo.Geolocator.openLocationSettings();
              Navigator.of(context).pop(); // Close the dialog after the user taps the button
            },
            child: const Text('Go to Settings'),
          ),
        ],
      ),
    );
  }

  openGPSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: RichText(
          text: TextSpan(
            text: "Please enable your device's GPS to receive your location. This allows us to provide you with the 5 prayer times.",
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                text: 'We promise you that your location will not be shared with any third parties.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
