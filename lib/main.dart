import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:muslim_vision/blocs/all_bloc_providers/all_bloc_providers.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/prayer_procedure_screen.dart';
import 'package:muslim_vision/views/pages/prayer_procedure_screen/salat_procedure_screen.dart';
import 'package:muslim_vision/splash_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'global_variable.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize()); // GOOGLE AD-MOB
  //****************************Push Notification**********************
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //****************************Push Notification**********************
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Hive.initFlutter();
  await Hive.openBox('procedureBox');
  await Hive.openBox('tasbeehBox');
  await Hive.openBox('zakatBox');
  await Hive.openBox('themeBox');
  await Hive.openBox('namesOfAllahBox');
  await Hive.openBox('adhanNotificationBox');
  await Hive.openBox('utilsBox');
  await Hive.openBox('syncDataBox');
  await Hive.openBox('greetingsBox');
  await Hive.openBox('fivePillarsDataBox');
  await Hive.openBox('doabox');
  await Hive.openBox('names');
  await Hive.openBox('qurbaniDataBox');
  await Hive.openBox('salatTrackerBox');
  await Hive.openBox('salahReminderBox');
  await Hive.openBox('DMPath');
  await Hive.openBox('QuranBox');
  await Hive.openBox(BoxNames().medicineBox);

  //---- Just Audio Background ----
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await CommonFunctions().preloadedSVGs(svgImagespath); //save svg Image for faster app
  await CommonFunctions().preloadedVecs(vecImagesPath);

  runApp(
    EasyLocalization(supportedLocales: const [Locale('en'), Locale('bn')], path: 'assets/language', saveLocale: true, fallbackLocale: const Locale('bn'), startLocale: const Locale('bn'), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(deviceWidth, deviceHeight),
      builder: (_, child) {
        return MultiBlocProvider(

          providers: [...AllBlocProviders.getAllBlocProviders],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: lightTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/prayerProcedure': (context) => const PrayerProcedureScreen(),
              '/salatProcedure': (context) => const SalatProcedureScreen(),
            },
          ),
        );
      },
    );
  }
}
