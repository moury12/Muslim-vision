import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/controllers/services/doa_screen_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/arabic_line_splitter.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:share_plus/share_plus.dart';

class BookMarkForDoa extends StatefulWidget {
  const BookMarkForDoa({super.key});

  @override
  State<BookMarkForDoa> createState() => _BookMarkForDoaState();
}

class _BookMarkForDoaState extends State<BookMarkForDoa> {
  @override
  Widget build(BuildContext context) {
    final existingBookMark = Boxes().doaBox.get('BookMark', defaultValue: {});
    final modifiedBookMark = Map.from(existingBookMark);
    return Boxes().doaBox.get('BookMark') != null && Boxes().doaBox.get('BookMark').values.toList().length > 0
        ? ListView.builder(
            itemCount: Boxes().doaBox.get('BookMark').values.toList().length,
            itemBuilder: (context, index) {
              final bookMarkedElement = Boxes().doaBox.get('BookMark').values.toList()[index];
              final bookMarkedElementkeys = Boxes().doaBox.get('BookMark').keys.toList()[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
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
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${convertToBanglaNumber("${index + 1}")}. ${DoaScreenfunctions().cutStringAfterDot(bookMarkedElement['title'])}',
                                overflow: TextOverflow.ellipsis,
                                style: kStyleTextW500CP.copyWith(fontSize: 11.sp, color: kColorGreen),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () async {
                                        if (modifiedBookMark.containsKey(bookMarkedElementkeys)) {
                                          modifiedBookMark.remove(bookMarkedElementkeys);
                                          CommonFunctions().ShowMessage(context, ContentType.failure, "bookMark_removed".tr(), '');
                                        }
                                        //  else {
                                        //   modifiedBookMark[bookMarkedElementkeys] = {'duaindex': index, 'doa': widget.doas[index].detailsInBangla, 'title': widget.title};
                                        // }
                                        await Boxes().doaBox.put('BookMark', modifiedBookMark);
                                        // CommonFunctions().ShowMessage(context, ContentType.success, "BookMark Added", "BookMark Added Success");

                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.favorite, color: kColorGreen),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () async {
                                          await Share.shareWithResult("${bookMarkedElement['doa']}\nRef:-${bookMarkedElement['ref']}\nhttps://play.google.com/store/apps/details?id=com.muslim_vision");
                                        },
                                        icon: SvgPicture.asset(
                                          share,
                                          width: 20.w,
                                          height: 20.h,
                                          colorFilter: const ColorFilter.mode(kColorGreen, BlendMode.srcIn),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        arabicLineSplitter(
                          bookMarkedElement['doa'],
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
                                bookMarkedElement['ref'],
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
            })
        : Center(
            child: Text(
              "no_favorite_added".tr(),
              style: TextStyle(fontSize: 14.sp),
            ),
          );
  }
}
