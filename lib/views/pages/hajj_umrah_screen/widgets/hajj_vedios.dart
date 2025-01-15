import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/views/common_widgets/awesome_snack_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class HajjUmrahVedios extends StatefulWidget {
  String vedio;

  HajjUmrahVedios({required this.vedio, super.key});

  @override
  State<HajjUmrahVedios> createState() => _HajjUmrahVediosState();
}

class _HajjUmrahVediosState extends State<HajjUmrahVedios> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  String data = '';

  bool _isPlayerReady = false;

  final List<String> _ids = [];
  isInternest() async {
    bool isInternet = await CommonFunctions().hasInternetConnection();

    if (!isInternet) {
      final snackBar = aweSomeSnackBar(title: 'no_internet_connection'.tr(), subTitle: "please_try_with_internet_connection".tr(), contentType: ContentType.warning, duration: 3000);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _ids.add(widget.vedio);
    isInternest();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      },
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller.load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          //_showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: customAppBar('hajj_gide'.tr(), true, [], kStyleTextW600CW.copyWith(fontSize: 16.sp), context, () {
          Navigator.pop(context);
        }),
        body: ListView(
          children: [
            player,
            // ,
          ],
        ),
      ),
    );
  }
}
