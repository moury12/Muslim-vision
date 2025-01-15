// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:muslim_vision/controllers/services/common_strings.dart';
// import 'package:muslim_vision/global_variable.dart';
// import 'package:muslim_vision/models/doa_model.dart';

// import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
// import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
// import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/widgets/doas_doa.dart';
// import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
// import 'package:share_plus/share_plus.dart';

// class DoasCatgoryTitle extends StatelessWidget {
//   List<SubCategory> data;
//   String title;
//   DoasCatgoryTitle({
//     Key? key,
//     required this.data,
//     required this.title,
//   }) : super(key: key);
// int previousItemHashCode = 0;
//  Map<int, dynamic> selectedMapIndex = {};
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title,
//         true,
//         const [],
//         kStyleTextW400CW.copyWith(fontSize: 14.sp),
//         context,false
//       ),
//       body: SizedBox(
//            height: deviceHeight.h,
//         child: ListView.builder(
//            addAutomaticKeepAlives: true,
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               final currentItem = data[index];
//                if (currentItem.hashCode != previousItemHashCode) {
//                 debugPrint('item at index $index is being rebuilt');
//                 previousItemHashCode = currentItem.hashCode;
//                 selectedMapIndex.remove(index);
//               }
//               return ExpantionTileClass(
//                 index: index,
//                 selectedMapIndex: selectedMapIndex,
//                 data: data,
//               );
              
              
//                Card(
//                  surfaceTintColor: kColorWhite,
//                 child: ListTile(
//                   // leading: Text("${index + 1}.",
//                   //     style: kStyleTextW400CB.copyWith(fontSize: 13.sp)),
//                   title: Text(data[index].subCategoryInBangla, style: kStyleTextW400CB.copyWith(fontSize: 12.sp)),
//                   trailing: Icon(
//                     Icons.arrow_forward_ios,
//                     color: kColorGrey,
//                     size: 14.sp,
//                   ),
//                   onTap: () => Navigator.of(context).push(CustomPageRoute(
//                     child: DoasDoa(
//                       doas: data[index].data,
//                       title: data[index].subCategoryInBangla,
//                     ),
//                     direction: AxisDirection.left,
//                   )),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
// class ExpantionTileClass extends StatefulWidget {
//   final Map selectedMapIndex;
//   final int index;
//   final List<SubCategory> data;
//   const ExpantionTileClass(
//       {super.key, required this.data, required this.selectedMapIndex, required this.index});

//   @override
//   State<ExpantionTileClass> createState() => _ExpantionTileClassState();
// }
// class _ExpantionTileClassState extends State<ExpantionTileClass>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Card(
//       shadowColor: Colors.lightGreenAccent[400],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 5,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(5),
//         child: ExpansionTile(
//           maintainState: true,
//           onExpansionChanged: (value) {
//             if (value) {
//               widget.selectedMapIndex[widget.index] = widget.index.toString();
//             } else {
//               widget.selectedMapIndex.remove(widget.index);
//             }
//             setState(() {});
//           },
//           collapsedIconColor: kColorWhite,
//           collapsedTextColor: Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: kColorWhite,
//           collapsedBackgroundColor: kColorPrimary,
//           textColor: kColorBlackGray,
//           childrenPadding: EdgeInsets.symmetric(horizontal: 20.w),
//           leading: CircleAvatar(
//             backgroundColor: widget.selectedMapIndex.containsKey(widget.index)
//                 ? kColorPrimary
//                 : kColorGreen,
//             child: Center(
//               child: Text(
//                 "${widget.index + 1}",
//                 style: kStyleTextW500CW.copyWith(fontSize: 12.sp),
//               ),
//             ),
//           ),
//           title: Text(
//             widget.data[widget.index].subCategoryInBangla,
//             style: widget.selectedMapIndex.containsKey(widget.index)
//                 ? kStyleTextW400CB
//                 : kStyleTextW400CW,
//           ),
//           children: [
//             ...(widget.data[widget.index].data)
//                 .asMap()
//                 .map((i, e) => MapEntry(
//                     i,
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Row(
//                           //   crossAxisAlignment: CrossAxisAlignment.start,
//                           //   children: [
//                           //     Expanded(
//                           //       child: Text(
//                           //         "${widget.index + 1}.${i + 1}",
//                           //         style: kStyleTextW500CB.copyWith(
//                           //             fontSize: 15.sp),
//                           //       ),
//                           //     ),
//                           //     // Expanded(
//                           //     //   flex: 8,
//                           //     //   child: Text(
//                           //     //     e.detailsInBangla,
//                           //     //     style: kStyleTextW500CB.copyWith(
//                           //     //         fontSize: 15.sp),
//                           //     //   ),
//                           //     // ),
//                           //   ],
//                           // ),
                       
//                         Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 8.w,
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(8.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 'Dua-${widget.index + 1}.${i + 1}',
//                                 style: kStyleTextW500CP.copyWith(fontSize: 11.sp),
//                               ),
//                               IconButton(
//                                   onPressed: () async {
//                                     await Share.shareWithResult("${e.detailsInBangla}\nRef:-${e.refInBangla} \n Copy From: MUSLIM VISION APP");
//                                   },
//                                   icon: SvgPicture.asset(
//                                     share,
//                                     width: 20.w,
//                                     height: 20.h,
//                                   ))
//                             ],
//                           ),
//                           Divider(),
//                           Text(
//                            e.detailsInBangla,
//                             textDirection: TextDirection.ltr,
//                             style: kStyleTextW400CB.copyWith(fontSize: 16.sp),
//                           ),
//                           // Text(doas[index]['translate']!,style:  kStyleTextW600CYO.copyWith(fontSize:14.sp ),),
//                           // Text(doas[index]['meaning']!,style:  kStyleTextW500CB.copyWith(fontSize:16.sp ),),
//                           SizedBox(
//                             height: 10.h,
//                           ),

//                           ExpansionTile(
                             
//                             tilePadding: EdgeInsets.zero,
//                             childrenPadding: EdgeInsets.zero,

//                             title:const Text("Reference",style:  kStyleTextW500CP),
//                             children: [
//                               Text(
//                                 e.refInBangla,
//                                   style: kStyleTextW600CYO.copyWith(fontSize: 9.sp),
//                                 ),
//                             ],

//                            ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //   children: <Widget>[
//                           //     Expanded(
//                           //       flex: 8,
//                           //       child: Text(
//                           //       e.refInBangla,
//                           //         style: kStyleTextW600CYO.copyWith(fontSize: 9.sp),
//                           //       ),
//                           //     ),
//                           //     // Expanded(
//                           //     //   flex: 2,
//                           //     //   child: IconButton(
//                           //     //       onPressed: () {},
//                           //     //       icon: SvgPicture.asset(
//                           //     //         play,
//                           //     //         width: 30.w,
//                           //     //         height: 30.h,
//                           //     //       )),
//                           //     // )
//                           //   ],
//                           // )
                       
                       
//                         ],
//                       ),
//                     ),
//                   ),
              
              
              
//                           const SizedBox(
//                             height: 5,
//                           )
//                         ],
//                       ),
//                     )))
//                 .values
//                 .toList()
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => false;
// }
