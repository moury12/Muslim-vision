import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/waj_screen_bloc/waj_screen_bloc.dart';

import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/pages/waj_screen/waj_widgets/video_screen.dart';


class NewWajScreens extends StatefulWidget {
  const NewWajScreens({super.key});

  @override
  State<NewWajScreens> createState() => _NewWajScreensState();
}

class _NewWajScreensState extends State<NewWajScreens> {
  WajScreenBloc wajScreenBloc = WajScreenBloc();
  @override
  void initState() {
  
    super.initState();
    BlocProvider.of<WajScreenBloc>(context).add(WajLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (deviceHeight / 1.3).h,
      child: Column(
        children: [
          BlocBuilder<WajScreenBloc, WajScreenState>(
            buildWhen: (previous, current) => current is WajLoadedState,
            builder: (context, state) {
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
                          // setState(() {
                          // isanabel = true;
                          // youtubePlayer = YoutubePlayer(
                          //   controller: controllers,
                          //   showVideoProgressIndicator: true,
                          //   thumbnail: Text("Thamble"),
                          // );
                          //   vedioLinks = videoList;
                          // });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => VideoScreen(
                                    url: videoUrl.toString(),
                                    // videos: videoList,
                                    // youtubePlayer: youtubePlayer = YoutubePlayer(
                                    //   controller: controllers,
                                    //   showVideoProgressIndicator: true,
                                    //   thumbnail: Text("Thamble"),
                                    // ),
                                  ))));
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
                                // YoutubePlayer(
                                //   controller: controllers,
                                //   showVideoProgressIndicator: false,

                                //   // thumbnail: Image.network(
                                //   //   'https://img.freepik.com/premium-psd/new-modern-glow-effect-video-game-review-youtube-channel-thumbnail-web-banner-premium-psd-templa_623685-120.jpg?w=826',
                                //   //   height: (deviceHeight / 3).h,
                                //   //   width: (deviceWidth).w,
                                //   //   fit: BoxFit.cover,
                                //   // ),
                                // ),
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
        ],
      ),
    );
  }
}


// Widget showVideo(BuildContext context, YoutubePlayer youtubePlayer,List<Map<String, Object>> videos){
//   return Column(
//           children: [
//            youtubePlayer,
//                  Expanded(
//           child: ListView.builder(
//             itemCount:videos.length,
//             itemBuilder: (BuildContext ctx, int index) {
//               final videoInfo =videos[index];
//               final videoUrl = videoInfo['videoUrl'];

//               // Create a YouTubePlayerController
//               final YoutubePlayerController _controller = YoutubePlayerController(
//                 initialVideoId: YoutubePlayer.convertUrlToId(videoUrl.toString()) ?? "",
//                 flags: YoutubePlayerFlags(
//                   autoPlay: false,
//                 ),
//               );

//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => VideoScreen(
//                                 youtubePlayer: YoutubePlayer(
//                                   controller: _controller,
//                                   showVideoProgressIndicator: false,
//                                   thumbnail: Text("Thamble"),
//                                 ),
//                                 videos: videos
                                
//                               )));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       YoutubePlayer(
//                         controller: _controller,
//                         showVideoProgressIndicator: false,
//                         thumbnail: Text("Thamble"),
//                       ),
//                       SizedBox(height: 10),
//                       Text(videoInfo['name'].toString()),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
     
     
//           ],
//         );



// }



// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class NewWajScreen extends StatefulWidget {
//   const NewWajScreen({super.key});

//   @override
//   State<NewWajScreen> createState() => _NewWajScreenState();
  
// }

// class _NewWajScreenState extends State<NewWajScreen> {

//    List<String> urls=["https://www.youtube.com/watch?v=rq0VXs_qCfw&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=CI-Y3G8ijqg&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=2&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=2pt2_EtVgcQ&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=3&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=rtfUhpB6MxQ&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=4&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=yUt3SrbVaew&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=5&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=Z3gJKyGwP0Y&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=6&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=xOb1qComDu8&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=9&ab_channel=MizanurRahmanAzhari",
//                           "https://www.youtube.com/watch?v=bv5hT0cglvE&list=PLbj12whCP4wu0Dw-3kMTzRAkVEwugDSzh&index=10&ab_channel=MizanurRahmanAzhari",
                         
//   ];
//   List<Widget> widgets=[];
//   @override
//   void initState() {
    
//     vedios();
//     // const url='https://www.youtube.com/watch?v=E_kL_cZycLo&ab_channel=MizanurRahmanAzhari';
   
    
//     super.initState();
//   }
//   @override
//  void deactivate(){
//     controller.pause();
//     super.deactivate();}
//   late YoutubePlayerController controller;
//     List<Widget> vedios(){
//       for(int i=0;i<urls.length;i++){
//        controller=YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(urls[i])!,
//     flags: const YoutubePlayerFlags(
//       mute: false,
//       loop: false,
//       autoPlay:  false
      
//     ));

//     widgets.add(YoutubePlayer(controller: controller),);
   
  
    
//     }
//     return widgets;

//     }
    
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: widgets
//       ),
//     );
//     // return YoutubePlayerBuilder(
//     //   player: YoutubePlayer(controller: controller),
//     // builder:(context,player)=> Column(
//     //     children: [
//     //       player
          
          
//     //     ],
//     //   ),
//     // );
//   }
// }
