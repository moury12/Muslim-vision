import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
import 'package:muslim_vision/views/common_widgets/bottom_nav_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/sync_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SplashScreenBloc>(context).add(SplashScreenLoadedEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenErrorState) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('an_error_occured'.tr()),
                content: Text(state.errorMsg),
                actions: [Text('please_resart_musim_vision_and_try_again'.tr())],
              ),
            );
          }
          if (state is SplashScreenLoadedState) {
            Navigator.pushAndRemoveUntil(
                context,
                CustomPageRoute(
                  child: BottomNavBar(
                    index: 0,
                  ),
                  direction: AxisDirection.left,
                ),
                (route) => false);
          } else if (state is SplashScreenMessageState) {
            final snackBar = aweSomeSnackBar(title: state.msg, subTitle: "please_try_with_internet_connection".tr(), contentType: ContentType.failure, duration: 2000);

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            //  BlocProvider.of<SplashScreenBloc>(context).add(SplashScreenLoadedEvent());
          }
        },
        child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          buildWhen: (previous, current) => current is SplashScreenLoadingState || current is SplashScreenSyncState,
          builder: (context, state) {
            // if (state is SplashScreenLocationPermissionState) {
            //   return const TurnOnLocationScreen();
            // }
            // if (state is SplashScreenNotificationPermissionState) {
            //   return const TurnOnNotificationScreen();
            // }
            if (state is SplashScreenSyncState) {
              return const SyncScreen();
            }
            if (state is SplashScreenLoadingState) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(splashFrame), fit: BoxFit.fill),
                ),
                child: Center(
                  child: FadeTransition(
                    opacity: _animation,
                    child: SvgPicture.asset(splashIcon),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
