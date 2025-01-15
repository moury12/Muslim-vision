// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/models/five_pillars_of_islam_model.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:vector_graphics/vector_graphics.dart';

class FivePillarsOfIslamDetatils extends StatelessWidget {
  final FivePillarsOfIslamModel fivePillarsOfIslamModel;
  const FivePillarsOfIslamDetatils({super.key, required this.fivePillarsOfIslamModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('five_pillars_of_islam'.tr(), true, [], kStyleTextW600CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: kColorDeepLightYellow2, width: 2.w), borderRadius: BorderRadius.circular(10.r), color: kColorGreen.withOpacity(0.85)),
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: VectorGraphic(
                        width: deviceWidth.w,
                        fit: BoxFit.fill,
                        loader: AssetBytesLoader(
                          '${fivePillarsOfIslamModel.data[0].imageUrl}.vec',
                        ),
                      )
                      // SvgPicture.asset(
                      //   fivePillarsOfIslamModel.data[0].imageUrl,
                      //   width: deviceWidth.w,
                      //   fit: BoxFit.fill,
                      // )
                      //  Image.asset(
                      //   fivePillarsOfIslamModel.data[0].imageUrl,
                      //   //width: deviceWidth.w,
                      //   //fit: BoxFit.fill,
                      // ),
                      ),
                )),
            SizedBox(height: 6.h),
            Expanded(
                flex: 11,
                child: Card(
                  surfaceTintColor: kColorWhite,
                  color: kColorWhite,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: ListView(children: [
                      Text(
                        fivePillarsOfIslamModel.categoryInBangla,
                        style: kStyleTextW500CP.copyWith(fontSize: 17.sp, color: kColorGreen),
                      ),
                      const Divider(),
                      Text(
                        fivePillarsOfIslamModel.data[0].detailsInBangla,
                        textAlign: TextAlign.justify,
                        style: kStyleTextW400CGR.copyWith(fontSize: 15.sp, color: kColorBlack),
                      ),
                    ]),
                  ),
                )),
            const Expanded(flex: 2, child: SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
