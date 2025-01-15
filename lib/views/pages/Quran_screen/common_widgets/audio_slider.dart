import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class AudioSlider extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final Map surahInfo;
  const AudioSlider(
      {super.key, required this.audioPlayer, required this.surahInfo});

  @override
  State<AudioSlider> createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool shouldBuild = false;

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    int minutes = duration.inMinutes;
    int remainingSeconds = duration.inSeconds % 60;

    return '${convertToBanglaNumber(minutes.toString())} :${convertToBanglaNumber(remainingSeconds.toString().padLeft(2, '0'))}';
  }

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.positionStream.listen((event) {
      if (mounted) {
        setState(() {
          position = event;
        });
      }
    });

    widget.audioPlayer.durationStream.listen((event) {
      if (mounted) {
        setState(() {
          if (event != null) {
            duration = event;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.surahInfo['surahName'].toString(),
              style: kStyleTextW500CW),
          SizedBox(
            height: 10.h,
            child: SliderTheme(
              data: SliderThemeData(
                  thumbColor: Colors.green,
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0)),
              child: Slider(
                activeColor: kColorWhite,
                inactiveColor: Colors.white.withOpacity(0.2),
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: ((value) async {
                  final position = Duration(seconds: value.toInt());
                  widget.audioPlayer.seek(position);
                  await widget.audioPlayer.play();
                }),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(position.inSeconds),
                style: const TextStyle(fontSize: 12, color: kColorWhite),
              ),
              Text(
                formatTime((duration - position).inSeconds),
                style: const TextStyle(fontSize: 12, color: kColorWhite),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AudioSliderStatic extends StatefulWidget {
  final Map surahInfo;
  const AudioSliderStatic({super.key, required this.surahInfo});

  @override
  State<AudioSliderStatic> createState() => _AudioSliderStaticState();
}

class _AudioSliderStaticState extends State<AudioSliderStatic> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool shouldBuild = false;

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    int minutes = duration.inMinutes;
    int remainingSeconds = duration.inSeconds % 60;

    return '${convertToBanglaNumber(minutes.toString())} :${convertToBanglaNumber(remainingSeconds.toString().padLeft(2, '0'))}';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.surahInfo['surahName'].toString(),
              style: kStyleTextW500CW),
          SizedBox(
            height: 10.h,
            child: SliderTheme(
              data: SliderThemeData(
                  thumbColor: Colors.green,
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0)),
              child: Slider(
                activeColor: kColorWhite,
                inactiveColor: Colors.white.withOpacity(0.2),
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: ((value) {}),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(position.inSeconds),
                style: const TextStyle(fontSize: 12, color: kColorWhite),
              ),
              Text(
                formatTime((duration - position).inSeconds),
                style: const TextStyle(fontSize: 12, color: kColorWhite),
              ),
            ],
          )
        ],
      ),
    );
  }
}
