import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class CustomButtonWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isPng;
  final Function() onPressed;
  const CustomButtonWidget({Key? key, required this.imageUrl, required this.title, required this.onPressed, required this.isPng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Column(
        children: [
          isPng
              ? Image.asset(
                  imageUrl,
                  height: 50.h,
                )
              : SvgPicture.asset(
                  imageUrl,
                  height: 50.h,
                ),

          // VectorGraphic(
          //   height: 50.h,
          //   loader: AssetBytesLoader(
          //     '$imageUrl.vec',
          //   ),
          // ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: kStyleTextW500CBL.copyWith(fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
