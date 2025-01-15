import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/pages/hajj_umrah_screen/widgets/pdf_viewer.dart';
import 'package:muslim_vision/views/pages/hajj_umrah_screen/widgets/vedios.dart';

import '../../themes/light_theme. dart.dart';

class HajjUmrahScreen extends StatefulWidget {
  const HajjUmrahScreen({super.key});

  @override
  State<HajjUmrahScreen> createState() => _HajjUmrahScreenState();
}

class _HajjUmrahScreenState extends State<HajjUmrahScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "hajj_umrah".tr(),
            style: kStyleTextW500CW.copyWith(fontSize: 16.sp),
          ),
          actions: const [],
          bottom: TabBar(
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Text(
                'book'.tr(),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: kStyleTextW600CW.copyWith(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
              ),
              Text(
                'videos'.tr(),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: kStyleTextW600CW.copyWith(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
              ),
            ],
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorWeight: 3,
            labelPadding: const EdgeInsets.all(5),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          child: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PDFScreen(
                path: 'assets/pdf/Hajj book Bangla.pdf',
              ),
              VediosPage(),
            ],
          ),
        ),
      ),
    );
  }
}
