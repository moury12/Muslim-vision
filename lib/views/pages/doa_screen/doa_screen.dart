import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/all_doa_bloc/doa_search_bloc/doa_search_bloc.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/categories/categories.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/widgets/bookmark_doa.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/widgets/doas_doa.dart';
import 'package:muslim_vision/views/pages/doa_screen/surah_for_prayer_screen.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DoaSearchBloc>(context).add(IsSearchEvent(false, ''));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<DoaSearchBloc, DoaSearchState>(
        builder: (context, state) {
          if (state is DoaSecrchClickState) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<DoaSearchBloc>(context)
                        .add(IsSearchEvent(false, ''));
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                centerTitle: true,
                title: SizedBox(
                  height: 50.h,
                  child: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Search here...',
                      hintStyle: kStyleTextW400CW,
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      BlocProvider.of<DoaSearchBloc>(context)
                          .add(IsSearchEvent(true, value));
                    },
                    style: kStyleTextW400CW,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<DoaSearchBloc>(context)
                          .add(IsSearchEvent(false, ''));
                    },
                    icon: const Icon(
                      Icons.close,
                      color: kColorWhite,
                    ),
                  )
                ],
                bottom: null,
              ),
              body: state.searchValue.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.searchValue.length,
                      itemBuilder: (context, index) => Card(
                            color: kColorWhite,
                            child: ListTile(
                              title: Text(
                                  state.searchValue[index].subCategoryInBangla,
                                  style: kStyleTextW400CB.copyWith(
                                      fontSize: 12.sp)),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: kColorGrey,
                                size: 14.sp,
                              ),
                              onTap: () =>
                                  Navigator.of(context).push(CustomPageRoute(
                                child: DoasDoa(
                                  oindex: index,
                                  doas: state.searchValue[index].data,
                                  title: state
                                      .searchValue[index].subCategoryInBangla,
                                ),
                                direction: AxisDirection.left,
                              )),
                            ),
                          ))
                  : Center(
                child: Text("doa_not_found".tr(),style: TextStyle(fontSize: 14.sp),),
              )
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "all_dua".tr(),
                style: kStyleTextW500CW.copyWith(fontSize: 16.sp),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<DoaSearchBloc>(context)
                        .add(IsSearchEvent(true, ''));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: kColorWhite,
                  ),
                )
              ],
              bottom: TabBar(
                dragStartBehavior: DragStartBehavior.down,
                tabs: [
                  Text(
                    'categories'.tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: kStyleTextW600CW.copyWith(
                        fontSize: 13.sp, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    'surah_for_prayer'.tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: kStyleTextW600CW.copyWith(
                      fontSize: 13.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'favorite'.tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: kStyleTextW600CW.copyWith(
                        fontSize: 13.sp, overflow: TextOverflow.ellipsis),
                  ),
                ],
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorWeight: 3,
                labelPadding: const EdgeInsets.all(5),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(5.r),
              child: const TabBarView(
                children: [
                  AllDoasCategories(),
                  SurahForPrayer(),
                  BookMarkForDoa()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
