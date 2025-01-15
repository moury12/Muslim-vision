// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:muslim_vision/database/boxes.dart';
// import 'package:muslim_vision/views/common_widgets/turn_on_location_widget.dart';

// class NearbyMosques extends StatefulWidget {
//   const NearbyMosques({Key? key}) : super(key: key);

//   @override
//   State<NearbyMosques> createState() => _NearbyMosquesState();
// }

// class _NearbyMosquesState extends State<NearbyMosques> {
//   InAppWebViewController? webViewCtrl;

//   @override
//   Widget build(BuildContext context) {
//     final lat = Boxes().utilsBox.get('lat');
//     final long = Boxes().utilsBox.get('long');
//     String url = Boxes().syncBox.get('nearbymasjid');

//     return lat != null && long != null
//         ? SafeArea(
//             child: InAppWebView(
//               initialUrlRequest: URLRequest(url: Uri.parse("${url.split('@latitude,longitude')[0]}$lat,$long${url.split('@latitude,longitude')[1]}")),
//               onWebViewCreated: (controller) {
//                 webViewCtrl = controller;
//               },
//             ),
//           )
//         : const Scaffold(
//             body: TurnOnLocationWidget(),
//           );
//   }
// }
