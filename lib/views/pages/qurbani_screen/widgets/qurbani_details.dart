import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/models/qurbani_model.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class QurbaniDetatils extends StatelessWidget {
  final QurbaniModel qurbaniModel;
  const QurbaniDetatils({super.key, required this.qurbaniModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('qurbani'.tr(), true, [],
          kStyleTextW600CW.copyWith(fontSize: 14.sp), context, () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: SizedBox(
                  height: 220.h,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    qurbani_eid_img,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Expanded(
              flex: 11,
              child: Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0).r,
                ),
                surfaceTintColor: kColorWhite,
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: ListView(children: [
                    Text(
                      qurbaniModel.categoryInBangla,
                      style: kStyleTextW500CP.copyWith(
                          fontSize: 16.sp, color: kColorGreen),
                    ),
                    const Divider(),
                    Text(
                      qurbaniModel.data[0].detailsInBangla,
                      textAlign: TextAlign.justify,
                      style: kStyleTextW400CGR.copyWith(
                        fontSize: 15.sp,
                        color: kColorBlack,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // Expanded(
            //     child: Text(
            //   "widget.ref",
            //   style: kStyleTextW400CYO,
            // )),
            // Expanded(flex: 2, child: SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
