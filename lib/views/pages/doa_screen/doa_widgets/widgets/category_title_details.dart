// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/models/doa_model.dart';

import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/widgets/doas_doa.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class DoasCatgoryTitle extends StatelessWidget {
  List<SubCategory> data;
  String title;
  int cindex;
  DoasCatgoryTitle({
    Key? key,
    required this.cindex,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title,
          true,
          const [],
          kStyleTextW400CW.copyWith(
              fontSize: 16.sp, overflow: TextOverflow.ellipsis),
          context, () {
        Navigator.pop(context);
      }),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: index == 0 ? 8.0.h : 0),
              child: Container(
                //surfaceTintColor: kColorWhite,
                //surfaceTintColor: kColorlightYellow,
                //color: kColorWhite.withOpacity(0.7),
                //color: kColorWhite1,
                margin: EdgeInsets.only(bottom: 4.w, left: 8.w, right: 8.w),
                decoration: BoxDecoration(
                    color: kColorWhite, borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  // leading: Text("${index + 1}.",
                  //     style: kStyleTextW400CB.copyWith(fontSize: 13.sp)),
                  title: Text(data[index].subCategoryInBangla,
                      maxLines: 2,
                      style: kStyleTextW400CB.copyWith(
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kColorGrey,
                    size: 14.sp,
                  ),
                  onTap: () => Navigator.of(context).push(CustomPageRoute(
                    child: DoasDoa(
                      cIndex: cindex,
                      oindex: index,
                      doas: data[index].data,
                      title: data[index].subCategoryInBangla,
                    ),
                    direction: AxisDirection.left,
                  )),
                ),
              ),
            );
          }),
    );
  }
}
