// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/models/five_pillars_of_islam_model.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class CustomCardWidget extends StatelessWidget {
  final FivePillarsOfIslamModel fivePillarsOfIslamModel;
  final Function() onTap;
  const CustomCardWidget(
      {Key? key, required this.fivePillarsOfIslamModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xfffdacfa2), width: 2.w),
                  borderRadius: BorderRadius.circular(10),
                  // color: const Color(0xffffff3c9),
                  color: kColorGreen.withOpacity(0.85)),
              height: 122.h,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                      right: 0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(10.r)),
                          child: VectorGraphic(
                            loader: AssetBytesLoader(
                              '${fivePillarsOfIslamModel.data[0].imageUrl}.vec',
                            ),
                          )
                          //Image.asset(fivePillarsOfIslamModel.data[0].imageUrl),
                          )),
                  Positioned(
                    width: 320.w - 110.h,
                    height: 150.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            fivePillarsOfIslamModel.categoryInBangla,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: kColorWhite),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Text(
                              fivePillarsOfIslamModel.data[0].detailsInBangla,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kColorWhite),
                            ),
                          ),
                          // SizedBox(height: 5),
                          // InkWell(
                          //   highlightColor: Colors.transparent,
                          //   splashColor: Colors.transparent,
                          //   onTap: onTap,
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         'see_details'.tr(),
                          //         style: TextStyle(decoration: TextDecoration.underline, color: const Color(0xff84bd8d), fontSize: 12.sp, fontWeight: FontWeight.bold),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
