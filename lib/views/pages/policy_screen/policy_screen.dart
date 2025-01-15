import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({
    super.key,
    this.webViewController,
    required this.title,
  });
  final WebViewController? webViewController;
  final String title;

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  double webProgress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.webViewController?.setNavigationDelegate(NavigationDelegate(
      onProgress: (int progress) {
        webProgress = progress.toDouble() / 100;
        if (mounted) {
          setState(() {});
        }
      },
      onPageStarted: (url) {},
      onWebResourceError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('An Error Occured'),
            content: Text(error.toString()),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Go Back'))
            ],
          ),
        );
      },
    ));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: customAppBar(widget.title, true, [],
          kStyleTextW500CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          webProgress < 1
              ? SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(
                    value: webProgress,
                    color: Colors.blue,
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(child: WebViewWidget(controller: widget.webViewController!)),
        ],
      ),
    );
  }
}
