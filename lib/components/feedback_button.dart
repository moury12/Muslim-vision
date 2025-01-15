import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/constants/sizedbox_constant.dart';
import 'package:muslim_vision/constants/textstyle_constants.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/greeting_widgets/fonts_buttons.dart';
import 'package:muslim_vision/views/pages/zakat_screen/zakat_widgets/zakat_screen_customtextfeild.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_custom_text_field.dart';

class FeedBackButton extends StatefulWidget {
  @override
  _FeedBackButtonState createState() => _FeedBackButtonState();
}

class _FeedBackButtonState extends State<FeedBackButton> {
  TextEditingController feedbackController = TextEditingController();
  List<String> screenName = [
    'Home Screen',
    'Quran Screen',
    'Prayer Procedure Screen',
    'Qibla Screen',
    'Tasbeeh Screen',
    'Salat Screen',
    'Medicine List Screen',
    'More Screen',
    'Settings Screen',
  ];
  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            image: DecorationImage(
              image: AssetImage('assets/images/dialog_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "give_feedback".tr(),
              style: text16White,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              hint: Text("Select Screen",style: TextStyle(color: kColorPrimary,fontWeight: FontWeight.w600, fontSize: 12),),

              items: screenName
                  .map((e) => DropdownMenuItem(
                value: e,
                  child: Text(e.toString()))).toList(),
              onChanged: (value) {},
            ),
            TasbeehScreenCustomTextField(
              fontSize: 13,
              maxLines: 3,
              controller: feedbackController,
              hintText: "write_feedback".tr(),
              borderColor: kColorPrimary,
            ),
            SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  // Handle feedback submission here if needed
                },
                child: Text('submit'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.feedback_rounded,
        color: kColorPrimary,
      ),
      title: Text(
        "feedback".tr(),
        style: kStyleTextW500CP.copyWith(fontSize: 12.sp),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: kColorPrimary,
        size: 15.h,
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      onTap: () {
        _showFeedbackDialog();
      },
    );
  }
}
