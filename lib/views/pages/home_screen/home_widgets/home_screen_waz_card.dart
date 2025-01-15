import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/waj_screen_bloc/waj_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/pages/waj_screen/waj_widgets/video_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../../../common_widgets/custom_page_route_widget.dart';
import '../../waj_screen/waj_screen.dart';

class HomeScreenWazCard extends StatefulWidget {
  const HomeScreenWazCard({
    super.key,
  });

  @override
  State<HomeScreenWazCard> createState() => _HomeScreenWazCardState();
}

class _HomeScreenWazCardState extends State<HomeScreenWazCard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WajScreenBloc>(context).add(WajLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WajScreenBloc, WajScreenState>(
      buildWhen: (previous, current) => current is WajLoadedState,
      builder: (context, state) {
        if (state is WajLoadedState) {
         // print('------------------');
          //print(state.wajData[state.wajData.length - 1]['thamenl']);
          return Card(
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0).r,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kColorWhiteGrey.withOpacity(0.2),
                        radius: 15.0.r,
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: SvgPicture.asset(azan),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text('Latest Waj', style: kStyleTextW600CB.copyWith(fontSize: 12.sp)),
                    ],
                  ),
                  SizedBox(height: 8.0.h),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => VideoScreen(url: state.wajData[state.wajData.length - 1]['videoUrl'].toString()))));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 175.h,
                      // color: kColorPrimary,
                      child: Image.network(
                        state.wajData[state.wajData.length - 1]['thamenl'].toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  /*  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => VideoScreen(
                                    url: state.wajData[state.wajData.length - 2]
                                            ['videoUrl']
                                        .toString()))));
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 100.h,
                            child: Image.network(
                              state.wajData[state.wajData.length - 2]['thamenl']
                                  .toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => VideoScreen(
                                    url: state.wajData[state.wajData.length - 3]
                                            ['videoUrl']
                                        .toString()))));
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 100.h,
                            child: Image.network(
                              state.wajData[state.wajData.length - 3]['thamenl']
                                  .toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),*/
                  SizedBox(height: 8.0.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: const WazScreen(),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kColorWhiteGrey.withOpacity(0.2),
                        ),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(0),
                        ),
                      ),
                      child: Text(
                        'Watch More',
                        style: kStyleTextW600CP.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: DefaultCircularProgressIndicator(),
          );
        }
      },
    );
  }
}
