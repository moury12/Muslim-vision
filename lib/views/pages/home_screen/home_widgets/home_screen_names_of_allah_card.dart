// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/home_bloc/home_screen_names_of_allah_bloc/home_screen_names_of_allah_bloc.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class HomeScreenNamesOfAllahCard extends StatefulWidget {
  const HomeScreenNamesOfAllahCard({super.key});

  @override
  State<HomeScreenNamesOfAllahCard> createState() => _HomeScreenNamesOfAllahCardState();
}

class _HomeScreenNamesOfAllahCardState extends State<HomeScreenNamesOfAllahCard> {
  /*--------------------------------------- controllers ----------------------------------------*/
  final CardSwiperController controller = CardSwiperController();

  /*--------------------------------------- Variables ----------------------------------------*/
  int nameIndex = 0;

/*--------------------------------------- Functions ----------------------------------------*/
  Future<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    if (await CommonFunctions().hasInternetConnection()) {
      BlocProvider.of<HomeScreenNamesOfAllahBloc>(context).add(HomeScreenNamesOfAllahSwipeEvent(currentIndex!));

      return true;
    } else {
      final snackBar = aweSomeSnackBar(title: "no_internet_connection".tr(), subTitle: "please_try_with_internet_connection".tr(), contentType: ContentType.warning, duration: 2000);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenNamesOfAllahBloc>(context).add(HomeScreenNamesOfAllahLoadedEvent(controller));
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<HomeScreenNamesOfAllahBloc>(context).add(HomeScreenNamesOfAllahDisposeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0).r,
      ),
      color: kColorWhite,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Text('99_names_of_allah'.tr(), style: kStyleTextW700CP.copyWith(fontSize: 14.sp)),
          SizedBox(height: 20.h),
          BlocBuilder<HomeScreenNamesOfAllahBloc, HomeScreenNamesOfAllahState>(
            builder: (context, state) {
              if (state is HomeScreenNamesOfAllahLoadedState) {
                return SizedBox(
                  height: 250.h,
                  width: deviceWidth.w,
                  child: CardSwiper(
                    allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
                    cardsCount: state.namesOfAllah.length,
                    onSwipe: _onSwipe,
                    controller: controller,
                    backCardOffset: const Offset(0, -30),
                    padding: EdgeInsets.only(top: 30.h, bottom: 10.h, left: 20.w, right: 20.w),
                    numberOfCardsDisplayed: 3,
                    cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                      nameIndex = index;
                      return Container(
                        decoration: BoxDecoration(
                          color: kColorPrimary,
                          borderRadius: BorderRadius.circular(8.r),
                          gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [kColorPrimary, kColorDeepGreen2]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 20.h),
                            Text('${context.locale.toString() == 'en' ? nameIndex : convertToBanglaNumber(nameIndex.toString())} ${context.locale.toString() == 'en' ? 'of 99' : 'এর ${convertToBanglaNumber(99.toString())}'}', style: kStyleTextW400CW.copyWith(fontSize: 10.sp)),
                            SizedBox(height: 20.h),
                            Text(state.namesOfAllah[nameIndex]['arabic'], style: kStyleTextW700CW.copyWith(fontSize: 30.sp)),
                            Text(state.namesOfAllah[nameIndex]['name_in_bangla'], style: kStyleTextW700CW.copyWith(fontSize: 11.sp)),
                            SizedBox(height: 20.h),
                            Text(
                              '“${state.namesOfAllah[nameIndex]['meaning_in_bangla']}”',
                              textAlign: TextAlign.center,
                              style: kStyleTextW600CW.copyWith(fontSize: 11.sp),
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Text('error');
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<HomeScreenNamesOfAllahBloc>(context).add(HomeScreenNamesOfAllahResetEvent(nameIndex));
                },
                icon: Icon(
                  Icons.replay,
                  color: kColorPrimary,
                  size: 30.0.r,
                ),
              ),
              CircleAvatar(
                backgroundColor: kColorPrimary,
                child: IconButton(
                  onPressed: () async {
                    BlocProvider.of<HomeScreenNamesOfAllahBloc>(context).add(HomeScreenNamesOfAllahPlayAndPauseEvent(nameIndex));
                    // await player.setUrl(b.get('namesOfAllahBox')[nameIndex - 2]['audio_url']);
                    // if (isVolumeOn == true) {
                    //   await player.setVolume(1);
                    // } else {
                    //   await player.setVolume(0);
                    //   return;
                    // }
                    // player.playerStateStream.listen((playerState) {
                    //   if (playerState.playing == true) {
                    //     setState(() {
                    //       isPlaying = true;
                    //     });
                    //   }
                    //   if (playerState.processingState == ProcessingState.completed) {
                    //     setState(() {
                    //       isPlaying = false;
                    //     });
                    //     print('--------------------------------------------------------');
                    //     print(isPlaying);
                    //   }
                    //   print(playerState.processingState == ProcessingState.completed);
                    // });
                    // await player.play();
                  },
                  // icon: Icon(
                  //   isPlaying == true ? Icons.pause : Icons.play_arrow_rounded,
                  //   color: kColorWhite,
                  // ),
                  icon: BlocBuilder<HomeScreenNamesOfAllahBloc, HomeScreenNamesOfAllahState>(
                    buildWhen: (previous, current) => current is HomeScreenNamesOfAllahIsPlayingState,
                    builder: (context, state) {
                      if (state is HomeScreenNamesOfAllahIsPlayingState) {
                        return Icon(
                          state.isPlaying == true ? Icons.pause : Icons.play_arrow_rounded,
                          color: kColorWhite,
                        );
                      } else {
                        return const Icon(
                          Icons.play_arrow_rounded,
                          color: kColorWhite,
                        );
                      }
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<HomeScreenNamesOfAllahBloc>(context).add(HomeScreenNamesOfAllahIsVolumeOnEvent());
                },
                icon: BlocBuilder<HomeScreenNamesOfAllahBloc, HomeScreenNamesOfAllahState>(
                  buildWhen: (previous, current) => current is HomeScreenNamesOfAllahIsVolumeOnState,
                  builder: (context, state) {
                    if (state is HomeScreenNamesOfAllahIsVolumeOnState) {
                      return Icon(
                        state.isVolumeOn ? Icons.volume_down_rounded : Icons.volume_off,
                        color: kColorPrimary,
                        size: 36.0.r,
                      );
                    } else {
                      return Icon(
                        Icons.volume_down_rounded,
                        color: kColorPrimary,
                        size: 36.0.r,
                      );
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
