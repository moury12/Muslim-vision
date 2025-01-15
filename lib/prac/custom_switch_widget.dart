import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool isOn;

  const CustomSwitch({super.key, required this.isOn});
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
        color: widget.isOn ? Colors.green : Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isOn ? Colors.white : Colors.grey[700]!,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment:
        widget.isOn ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          widget.isOn?const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text("OFF"),
          ):SizedBox.shrink(),

          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          widget.isOn?const SizedBox.shrink():const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("ON",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}