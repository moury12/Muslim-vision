// // ignore_for_file: use_build_context_synchronously

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart' as geo;
// import 'package:muslim_vision/controllers/services/common_functions.dart';
// import 'package:muslim_vision/controllers/services/common_strings.dart';
// import 'package:muslim_vision/database/boxes.dart';
// import 'package:muslim_vision/turn_on_notification_screen.dart';
// import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
// import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
// import 'package:permission_handler/permission_handler.dart';

// class TurnOnLocationScreen extends StatefulWidget {
//   const TurnOnLocationScreen({super.key});

//   @override
//   State<TurnOnLocationScreen> createState() => _TurnOnLocationScreenState();
// }

// class _TurnOnLocationScreenState extends State<TurnOnLocationScreen>
//     with WidgetsBindingObserver {
//   AppLifecycleState? _appLifecycleState;
//   openPermissionDialog(context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Location Permission Required'),
//         content: RichText(
//           text: TextSpan(
//             text:
//                 'Please enable location permissions in the device settings, specifically ',
//             style: DefaultTextStyle.of(context).style,
//             children: const <TextSpan>[
//               TextSpan(
//                 text: 'Allow only while using the app',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               await openAppSettings();
//             },
//             child: const Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   openGPSDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: RichText(
//           text: TextSpan(
//             text:
//                 "Please enable your device's GPS to receive your location. This allows us to provide you with the 5 prayer times.",
//             style: DefaultTextStyle.of(context).style,
//             children: const <TextSpan>[
//               TextSpan(
//                 text:
//                     'We promise you that your location will not be shared with any third parties.',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showLoadingDialog(context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const Center(
//           child: CircularProgressIndicator(color: kColorPrimary,),
//         );
//       },
//     );
//   }

//   _processLocationPermission() async {
//     final utilBox = Boxes().utilsBox;

//     /*-------------------------get user location----------------------*/
//     _showLoadingDialog(context);
//     try {
//       geo.Position currentPosition =
//           await CommonFunctions().determinePosition();

//       await utilBox.put('lat', currentPosition.latitude);
//       await utilBox.put('long', currentPosition.longitude);

//       debugPrint(currentPosition.toString());
//       /*-------------------------get city name----------------------*/
//       List<Placemark>? placeMarks =
//           await CommonFunctions().getCityName(currentPosition);
//       if (placeMarks != null) {
//         String? city = placeMarks[0].locality;

//         if (city != utilBox.get('city')) {
//           await utilBox.put('city', city);
//         }
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }

//     var status = await Permission.locationWhenInUse.status;
//     if (context.mounted) {
//       Navigator.pop(context);
//     }

//     if (status.isGranted && context.mounted && utilBox.isNotEmpty) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           CustomPageRoute(
//             child: const TurnOnNotificationScreen(),
//             direction: AxisDirection.left,
//           ),
//           (route) => false);
//     }

//     if (status.isDenied || status.isPermanentlyDenied) {
//       if (context.mounted) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//         await openPermissionDialog(context);
//         return;
//       }
//     }

//     if (utilBox.isEmpty) {
//       openGPSDialog();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     _appLifecycleState = state;
//     if (_appLifecycleState == AppLifecycleState.hidden) {
//       var status = await Permission.locationWhenInUse.status;
//       if (status.isGranted && mounted) {
//         _processLocationPermission();
//       }
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kColorWhite,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(),
//               Center(
//                   child: SvgPicture.asset(
//                 turn_on_location,
//                 fit: BoxFit.fill,
//                 height: 242.h,
//                 width: 242.h,
//               )),
//               SizedBox(
//                 height: 40.h,
//               ),
//               Text(
//                 'turn_on_location_for_qibla'.tr(),
//                 style: kStyleTextW600CB.copyWith(fontSize: 16.sp),
//                 textAlign: TextAlign.left,
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Text(
//                 'turn_on_location_to_use_the_qibla_compass_feature_so_you_can_perform_your_prayer_in_the_right_direction'
//                     .tr(),
//                 style: kStyleTextW500CBG.copyWith(fontSize: 12.sp),
//                 textAlign: TextAlign.left,
//               ),
//               const Spacer(),
//               GestureDetector(
//                 onTap: () async {
//                   bool serviceEnabled =
//                       await geo.Geolocator.isLocationServiceEnabled();
//                   if (!serviceEnabled) {
//                     final utilBox = Boxes().utilsBox;
//                     try {
//                       geo.Position currentPosition =
//                           await CommonFunctions().determinePosition();

//                       await utilBox.put('lat', currentPosition.latitude);
//                       await utilBox.put('long', currentPosition.longitude);
//                     } catch (e) {
//                       debugPrint(e.toString());
//                     }
//                   }

//                   await _processLocationPermission();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5.h),
//                     color: kColorPrimary,
//                   ),
//                   height: 46.h,
//                   child: Center(
//                     child: Text(
//                       'turn_on_GPS_location'.tr(),
//                       style: kStyleTextW600CW.copyWith(fontSize: 14.sp),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//             ],
//           ),
//         ));
//   }
// }
