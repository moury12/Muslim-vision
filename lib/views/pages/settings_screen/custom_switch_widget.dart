import 'package:flutter/material.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class CustomSwitch extends StatefulWidget {
  final bool isOn;
  final bool isloading;

  const CustomSwitch({super.key, required this.isOn, required this.isloading});
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  // bool widget.isOn = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 90,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: widget.isOn ? kColorPrimary : kColorLightDeepGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isOn ? kColorPrimaryAccent : kColorDeepGreen,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            widget.isOn ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          widget.isOn
              ? Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    "ON",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SizedBox.shrink(),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: widget.isOn ? Colors.white : kColorPrimary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: widget.isloading
                ? Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: DefaultCircularProgressIndicator(
                        stroke: 2,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          widget.isOn
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "OFF",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
