// import 'package:flutter/material.dart';
// import 'package:muslim_vision/views/pages/waj_screen/waj_Widgets/models/channel_model.dart';
// import 'package:muslim_vision/views/pages/waj_screen/waj_Widgets/models/video_model.dart';
// import 'package:muslim_vision/views/pages/waj_screen/waj_Widgets/services/api_service.dart';
// import 'package:muslim_vision/views/pages/waj_screen/waj_Widgets/video_screen.dart';

// class WajNewScreen extends StatefulWidget {
//   @override
//   _WajNewScreenState createState() => _WajNewScreenState();
// }

// class _WajNewScreenState extends State<WajNewScreen> {
//    Channel? _channel;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _initChannel();
//   }

//   _initChannel() async {
//     Channel channel = await APIService.instance.fetchChannel(channelId: 'UCxStLx7yb96MGBfIMo20x7Q');
//     setState(() {
//       _channel = channel;
//     });
//   }

//   _fristVedio(Video vedio) {
//     return InkWell(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
          // builder: (_) => VideoScreen(id: vedio.id),
//         ),
//       ),
//       child: Card(
//         child: Image(
//           width: 150.0,
//           image: NetworkImage(
//             vedio.thumbnailUrl,
//           ),
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }

//   _buildVideo(Video video) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => VideoScreen(id: video.id),
//         ),
//       ),
//       child: Card(
//         child: Image(
//           width: 150.0,
//           fit: BoxFit.contain,
//           image: NetworkImage(video.thumbnailUrl),
//         ),
//       ),
//     );
//   }

//   _loadMoreVideos() async {
//     _isLoading = true;
//     List<Video> moreVideos = await APIService.instance.fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);

//     List<Video> allVideos = _channel!.videos..addAll(moreVideos);
//     setState(() {
//       _channel!.videos = allVideos;
//     });
//     _isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unnecessary_null_comparison
//     return _channel != null
//         ? NotificationListener<ScrollNotification>(
//             onNotification: (ScrollNotification scrollDetails) {
//               if (!_isLoading &&
//                   _channel!.videos.length != int.parse(_channel!.videoCount) &&
//                   scrollDetails.metrics.pixels == scrollDetails.metrics.maxScrollExtent) {
//                 _loadMoreVideos();
//               }
//               return false;
//             },
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of items in each row
//                 mainAxisSpacing: 8.0, // Spacing between rows
//                 crossAxisSpacing: 8.0, // Spacing between columns
//               ),
//               // ignore: unnecessary_null_comparison
//               itemCount:_channel == null ? 0 :  _channel!.videos.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // if (index == 0) {
//                 //   return _fristVedio(_channel.videos[index]);
//                 // }
//                 Video videos = _channel!.videos[index];
//                 return _channel!=null? _buildVideo(videos):DefaultCircularProgressIndicator();
//               },
//             )
//             //  ListView.builder(
//             //   itemCount: 1 + _channel.videos.length,
//             //   itemBuilder: (BuildContext context, int index) {
//             //     if (index == 0) {
//             //       return _fristVedio(_channel.videos[index]);
//             //     }
//             //      Video videos = _channel.videos[index-1];

//             //     return _buildVideo(videos);
//             //   },
//             // ),
//             )
//         : Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 Theme.of(context).primaryColor, // Red
//               ),
//             ),
//           );
//   }
// }
