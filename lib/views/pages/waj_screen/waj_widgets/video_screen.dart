// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/waj_screen_bloc/waj_screen_bloc.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  // final YoutubePlayer youtubePlayer;
  // List<Map<String, Object>> videos;
  final String url;

  const VideoScreen({
    Key? key,
    // required this.youtubePlayer,
    required this.url,
    // required this.videos,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    widget.url == "" ? BlocProvider.of<WajScreenBloc>(context).add(WajPlayEvent(widget.url)) : const SizedBox.shrink();
    BlocProvider.of<WajScreenBloc>(context).add(WajLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar('videos'.tr(), true, [], kStyleTextW400CW.copyWith(fontSize: 16.sp), context, (){Navigator.pop(context);}),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: BlocBuilder<WajScreenBloc, WajScreenState>(
                    buildWhen: (previous, current) => current is WajPlayState,
                    builder: (context, state) {
                      if (state is WajPlayState) {
                        YoutubePlayerController controllers = YoutubePlayerController(
                          initialVideoId: YoutubePlayer.convertUrlToId(state.url.toString()) ?? "",
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            loop: false,
                          ),
                        );
                        return YoutubePlayer(
                          controller: controllers,
                          showVideoProgressIndicator: true,
                        );
                      } else {
                        return const Center(
                          child: DefaultCircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: BlocBuilder<WajScreenBloc, WajScreenState>(
                    buildWhen: (previous, current) => current is WajLoadedState,
                    builder: (context, state) {
                    //  print(state);
                      if (state is WajLoadedState) {
                        return SizedBox(
                          height: (deviceHeight / 1.233).h,
                          child: ListView.builder(
                            itemCount: state.wajData.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              final videoInfo = state.wajData[index];
                              final videoUrl = videoInfo['videoUrl'];
                              final videothamnel = videoInfo['thamenl'];
                              // Create a YouTubePlayerController

                              return InkWell(
                                
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  BlocProvider.of<WajScreenBloc>(context).add(WajPlayEvent(videoUrl.toString()));
                                  // BlocProvider.of<WajScreenBloc>(context).add(WajLoadedEvent());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: (deviceHeight / 3).h,
                                    width: (deviceWidth).w,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          videothamnel.toString(),
                                          height: (deviceHeight / 4).h,
                                          width: (deviceWidth).w,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(videoInfo['name'].toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: DefaultCircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            )

            //  YoutubePlayer(
            //   controller: _controller,
            //   showVideoProgressIndicator: true,
            //   onReady: () {
            //     print('Player is ready.');
            //   },
            // ),

            ));
  }
}
