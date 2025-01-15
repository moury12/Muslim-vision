// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/controllers/services/dailymuslim_data_json.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class DailyMuslimScreen extends StatefulWidget {
  const DailyMuslimScreen({super.key});

  @override
  State<DailyMuslimScreen> createState() => _DailyMuslimScreenState();
}

class _DailyMuslimScreenState extends State<DailyMuslimScreen> {
  Map<int, dynamic> selectedMapIndex = {};
  int previousItemHashCode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          "daily_muslim".tr(),
          true,
          const [
            // Icon(
            //   Icons.search,
            //   color: kColorWhite,
            // )
          ],
          kStyleTextW400CW.copyWith(fontSize: 12.sp),
          context, () {
        Navigator.pop(context);
      }),
      body: SizedBox(
        height: deviceHeight.h,
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: dailymuslimjsondata.length,
            itemBuilder: (context, index) {
              final currentItem = dailymuslimjsondata[index];

              if (currentItem.hashCode != previousItemHashCode) {
                debugPrint('item at index $index is being rebuilt');
                previousItemHashCode = currentItem.hashCode;
                selectedMapIndex.remove(index);
              }
              return ExpantionTileClass(
                index: index,
                selectedMapIndex: selectedMapIndex,
              );
            }),
      ),
    );
  }
}

class ExpantionTileClass extends StatefulWidget {
  final Map selectedMapIndex;
  final int index;
  const ExpantionTileClass({super.key, required this.selectedMapIndex, required this.index});

  @override
  State<ExpantionTileClass> createState() => _ExpantionTileClassState();
}

// Hack from https://stackoverflow.com/questions/57980225/flutter-issue-listview-rebuilding-items-when-scrolled
class _ExpantionTileClassState extends State<ExpantionTileClass> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      // shadowColor: Colors.lightGreenAccent[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ExpansionTile(
          maintainState: true,
          onExpansionChanged: (value) {
            if (value) {
              widget.selectedMapIndex[widget.index] = widget.index.toString();
            } else {
              widget.selectedMapIndex.remove(widget.index);
            }
            setState(() {});
          },
          collapsedIconColor: kColorWhite,
          collapsedTextColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: kColorWhite,
          collapsedBackgroundColor: kColorPrimary,
          textColor: kColorBlackGray,
          childrenPadding: EdgeInsets.symmetric(horizontal: 20.w),
          leading: CircleAvatar(
            backgroundColor: widget.selectedMapIndex.containsKey(widget.index) ? kColorPrimary : kColorGreen.withOpacity(0.6),
            child: Center(
              child: Text(
                context.locale.toString() == 'en' ? "${widget.index + 1}" : convertToBanglaNumber("${widget.index + 1}"),
                style: kStyleTextW500CW.copyWith(fontSize: 12.sp),
              ),
            ),
          ),
          title: Text(
            dailymuslimjsondata[widget.index]["category"],
            style: widget.selectedMapIndex.containsKey(widget.index) ? kStyleTextW500CB.copyWith(fontSize: 15.sp, color: kColorGreen) : kStyleTextW400CW,
          ),
          children: [
            ...(dailymuslimjsondata[widget.index]["items"] as List<dynamic>)
                .asMap()
                .map((i, e) => MapEntry(
                    i,
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  context.locale.toString() == 'en' ? "${widget.index + 1}.${i + 1}" : convertToBanglaNumber("${widget.index + 1}.${i + 1}"),
                                  style: kStyleTextW500CB.copyWith(fontSize: 14.sp, color: kColorBlack, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  e["sub category"],
                                  style: kStyleTextW500CB.copyWith(fontSize: 14.sp, color: kColorBlack, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Text(
                            e["details"],
                            style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    )))
                .values
                .toList()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
