import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class HomeScreenBannerSection extends StatelessWidget {
  HomeScreenBannerSection({super.key, this.webViewController, required this.width, required this.height});
  WebViewController? webViewController;
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0).r,
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: WebViewWidget(controller: webViewController!),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
