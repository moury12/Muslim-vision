// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/controllers/services/doa_screen_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';

import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../models/doa_model.dart';
import '../../../../common_widgets/arabic_line_splitter.dart';

class DoasDoa extends StatefulWidget {
  List<Datum> doas;
  String title;
  int oindex;
  int? cIndex;
  DoasDoa({
    Key? key,
    required this.doas,
    required this.title,
    required this.oindex,
    this.cIndex,
  }) : super(key: key);

  @override
  State<DoasDoa> createState() => _DoasDoaState();
}

class _DoasDoaState extends State<DoasDoa> {
  @override
  Widget build(BuildContext context) {
    final existingBookMark = Boxes().doaBox.get('BookMark', defaultValue: {});
    final modifiedBookMark = Map.from(existingBookMark);
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: customAppBar('dua'.tr(), true, const [], kStyleTextW400CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(DoaScreenfunctions().cutStringAfterDot(widget.title),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: kStyleTextW400CB.copyWith(
                          fontSize: 14.sp,
                          overflow: TextOverflow.ellipsis,
                          color: kColorGreen,
                        )),
                  ))),
          Expanded(
            flex: 11,
            child: ListView.builder(
                itemCount: widget.doas.length,
                itemBuilder: (context, index) {
                  // final bookmarkKey = '${widget.oindex}_$index${widget.cIndex ?? ''}}';
                  final bookmarkKey = '${DoaScreenfunctions().getDuaId(widget.title)}_${widget.oindex}_$index';
                  return Padding(
                    padding: EdgeInsets.fromLTRB(8.w, index == 0 ? 8.w : 4.w, 8.w, 0),
                    child: Card(
                      color: kColorOffWhite,
                      surfaceTintColor: kColorOffWhite,
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${'dua'.tr()}-${context.locale.toString() == 'en' ? index + 1 : convertToBanglaNumber((index + 1).toString())}',
                                  /*'${widget.title}',*/
                                  style: kStyleTextW500CP.copyWith(fontSize: 14.sp, color: kColorGreen, fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        if (modifiedBookMark.containsKey(bookmarkKey)) {
                                          modifiedBookMark.remove(bookmarkKey);
                                          CommonFunctions().ShowMessage(context, ContentType.failure, "bookMark_removed".tr(), "");
                                        } else {
                                          modifiedBookMark[bookmarkKey] = {'duaindex': '$index', 'doa': widget.doas[index].detailsInBangla, 'title': widget.title, 'ref': widget.doas[index].refInBangla};
                                          CommonFunctions().ShowMessage(context, ContentType.success, "bookMark_add".tr(), "");
                                        }
                                        debugPrint('7rt7o8tyiehulig');
                                        debugPrint(bookmarkKey);
                                        debugPrint(modifiedBookMark[bookmarkKey].toString());
                                        await Boxes().doaBox.put('BookMark', modifiedBookMark);

                                        setState(() {});
                                      },
                                      icon: modifiedBookMark.containsKey(bookmarkKey)
                                          ? Icon(
                                              Icons.favorite,
                                              color: kColorPrimary,
                                              size: 20.sp,
                                            )
                                          : Icon(Icons.favorite_border, size: 20.sp, color: kColorGreen),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          debugPrint('8888');
                                          await Share.shareWithResult(
                                            "${widget.doas[index].detailsInBangla}\nRef:-${widget.doas[index].refInBangla}\nhttps://play.google.com/store/apps/details?id=com.muslim_vision",
                                          );
                                        },
                                        icon: SvgPicture.asset(
                                          share,
                                          width: 20.w,
                                          height: 20.h,
                                          colorFilter: const ColorFilter.mode(kColorGreen, BlendMode.srcIn),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            arabicLineSplitter(
                              widget.doas[index].detailsInBangla,
                              textStyleForBangla: TextStyle(fontSize: 15.sp),
                            ),
                            // Text(
                            //   doas[index].detailsInBangla,
                            //   textDirection: TextDirection.ltr,
                            //   style: kStyleTextW400CB.copyWith(fontSize: 16.sp),
                            // ),
                            // Text(doas[index]['translate']!,style:  kStyleTextW600CYO.copyWith(fontSize:14.sp ),),
                            // Text(doas[index]['meaning']!,style:  kStyleTextW500CB.copyWith(fontSize:16.sp ),),
                            SizedBox(
                              height: 10.h,
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                // dense: true,

                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "referance".tr(),
                                  style: kStyleTextW500CP.copyWith(fontSize: 12.sp, color: kColorGreen),
                                ),
                                children: [
                                  Text(
                                    widget.doas[index].refInBangla,
                                    style: kStyleTextW600CYO.copyWith(fontSize: 9.sp),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
