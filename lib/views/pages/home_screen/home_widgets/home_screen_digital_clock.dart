import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';

import '../../../themes/light_theme. dart.dart';

class CurrentTime extends StatefulWidget {
  final DateTime counter;
  const CurrentTime({Key? key, required this.counter}) : super(key: key);

  @override
  State<CurrentTime> createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  String count = '';
  Timer? t;
  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(seconds: 1), (timer) {
      count = DateFormat.jms().format(DateTime.now());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    t!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      context.locale.toString() == 'en' ? count : convertToBanglaNumber(count),
      style: kStyleTextW600CW.copyWith(fontSize: 10.sp),
    );
  }
}
