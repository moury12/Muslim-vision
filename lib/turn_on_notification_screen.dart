// // ignore_for_file: use_build_context_synchronously

// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:muslim_vision/blocs/splash_screen_bloc/splash_screen_bloc.dart';
// import 'package:muslim_vision/controllers/services/common_functions.dart';
// import 'package:muslim_vision/controllers/services/common_strings.dart';
// import 'package:muslim_vision/database/boxes.dart';
// import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
// import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
// import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
// import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
// import 'package:permission_handler/permission_handler.dart';

// class TurnOnNotificationScreen extends StatefulWidget {
//   const TurnOnNotificationScreen({super.key});

//   @override
//   State<TurnOnNotificationScreen> createState() =>
//       _TurnOnNotificationScreenState();
// }

// class _TurnOnNotificationScreenState extends State<TurnOnNotificationScreen>
//     with WidgetsBindingObserver {
//   AppLifecycleState? _appLifecycleState;
//   openPermissionDialog(context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text('notification_permission_required'.tr()),
//         content: Text('enable_notification_permissions'.tr()),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               openAppSettings();
//             },
//             child: const Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showLoadingDialog(context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Center(
//           child: AlertDialog(
//             backgroundColor: Colors.blueGrey[900],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(color: kColorPrimary,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//                 SizedBox(height: 16.h),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0).r,
//                   child: TypewriterText(
//                     text: 'syncing_for_the_first_time'.tr(),
//                     duration: const Duration(seconds: 1),
//                     textStyle: TextStyle(fontSize: 16.sp, color: kColorWhite),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   _processNotificationPermission() async {
//     PermissionStatus status = await Permission.notification.request();

//     if (status.isGranted && context.mounted) {
//       final utilBox = Boxes().utilsBox;
//       await utilBox.put('notification', 'approved');
//       BlocProvider.of<SplashScreenBloc>(context).add(SplashScreenLoadedEvent());
//       return;
//     }

//     if (status.isDenied || status.isPermanentlyDenied) {
//       if (context.mounted) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//         openPermissionDialog(context);
//       }
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
//       _processNotificationPermission();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SplashScreenBloc, SplashScreenState>(
//       listenWhen: (previous, current) =>
//           current is SplashScreenLoadedState ||
//           current is SplashScreenMessageState ||
//           current is SplashScreenLoadingState ||
//           current is SplashScreenErrorState,
//       listener: (context, state) async {
//         if (state is SplashScreenErrorState) {
//           Navigator.of(context).popUntil((route) => route.isFirst);
//           showDialog(
//             context: context,
//             builder: (BuildContext context) => AlertDialog(
//               title: const Text('An Error Occured'),
//               content: Text(state.errorMsg),
//               actions: const [
//                 Text('Please resart Musim Vision, and try again')
//               ],
//             ),
//           );
//         }
//         if (state is SplashScreenLoadingState) {
//           Navigator.of(context).popUntil((route) => route.isFirst);
//           if (await CommonFunctions().hasInternetConnection()) {
//             _showLoadingDialog(context);
//           }
//         }
//         if (state is SplashScreenMessageState) {
//           // if internet is not connected
//           final snackBar = aweSomeSnackBar(
//               title: state.msg,
//               subTitle: "please_try_with_internet_connection".tr(),
//               contentType: ContentType.failure,
//               duration: 2000);

//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(snackBar);
//         }
//         if (state is SplashScreenLoadedState) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               CustomPageRoute(
//                 child: BottomNavBar(
//                   index: 0,
//                 ),
//                 direction: AxisDirection.left,
//               ),
//               (route) => false);
//         }
//       },
//       child: Scaffold(
//           backgroundColor: const Color(0xffFCFFFE),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Spacer(),
//                 Center(
//                     child: SvgPicture.asset(
//                   turn_on_notification,
//                   fit: BoxFit.fill,
//                   height: 242.h,
//                   width: 242.h,
//                 )),
//                 SizedBox(
//                   height: 40.h,
//                 ),
//                 Text(
//                   'turn_on_notification_for_salat_alarm'.tr(),
//                   style: kStyleTextW600CB.copyWith(fontSize: 16.sp),
//                   textAlign: TextAlign.left,
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Text(
//                   'turn_on_the_notification_to_get_the_alarm_notification_on_salat_time_otherwise_you_can_not_use_the_alert_You_can_disable_the_alarm_from_the_alarm_settings_of_this_app'
//                       .tr(),
//                   style: kStyleTextW500CBG.copyWith(fontSize: 12.sp),
//                   textAlign: TextAlign.left,
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text(
//                   'note'.tr(),
//                   style: kStyleTextW500CBG.copyWith(
//                       fontSize: 12.sp,
//                       color: kColorRed,
//                       fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.left,
//                 ),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: () async {
//                     await _processNotificationPermission();
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5.h),
//                       color: kColorPrimary,
//                     ),
//                     height: 46.h,
//                     child: Center(
//                       child: Text(
//                         'turn_on_notification'.tr(),
//                         style: kStyleTextW600CW.copyWith(fontSize: 14.sp),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.h,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

// class TypewriterText extends StatefulWidget {
//   final String text;
//   final Duration duration;
//   final TextStyle textStyle;

//   const TypewriterText({
//     super.key,
//     required this.text,
//     required this.duration,
//     required this.textStyle,
//   });

//   @override
//   State<TypewriterText> createState() => _TypewriterTextState();
// }

// class _TypewriterTextState extends State<TypewriterText>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<int> _textAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: widget.duration,
//       vsync: this,
//     );

//     _textAnimation =
//         IntTween(begin: 0, end: widget.text.length).animate(_controller);

//     _controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         final currentLength = _textAnimation.value;
//         return Text(
//           widget.text.substring(0, currentLength),
//           style: widget.textStyle,
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
