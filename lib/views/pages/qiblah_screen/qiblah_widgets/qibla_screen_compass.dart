import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    return SmoothCompass(
      rotationSpeed: 200,
      isQiblahCompass: true,
      loadingAnimation: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              compass,
              fit: BoxFit.scaleDown,
              width: 200.w,
              height: 200.h,
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  height: 200.h,
                  width: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 218, 218, 218)
                        .withOpacity(0.5),
                  ),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  )),
                ),
              )),
        ],
      ),
      compassBuilder: (context, snapshot, child) {
        return AnimatedRotation(
          duration: const Duration(milliseconds: 800),
          turns: snapshot?.data?.turns ?? 0,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  compass,
                  fit: BoxFit.scaleDown,
                  width: 200.w,
                  height: 200.h,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 500),
                  turns: (snapshot?.data?.qiblahOffset ?? 0) / 360,
                  child: SvgPicture.asset(
                    compassNeedle,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
