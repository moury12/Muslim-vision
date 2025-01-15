import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muslim_vision/blocs/quran_bloc/quran-search/quran_search_bloc.dart';
import 'package:muslim_vision/constants/textstyle_constants.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/pages/Quran_screen/common_widgets/book_mark_widget.dart';
import 'package:muslim_vision/views/pages/Quran_screen/common_widgets/surah_name_card.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import '../../themes/light_theme. dart.dart';

class SurahNamesScreen extends StatefulWidget {
  const SurahNamesScreen({super.key});

  @override
  State<SurahNamesScreen> createState() => _SurahNamesScreenState();
}

class _SurahNamesScreenState extends State<SurahNamesScreen> {
  List<dynamic> surahInfo = [];
  List<dynamic> filteredSurahInfo = [];
  final quranBox = Boxes().quranBox;
  late Stream<BoxEvent> watchStream;

  @override
  void initState() {
    super.initState();
    watchStream = quranBox.watch();
    context.read<QuranSearchBloc>().add(QuranSearchLoadedEvent(null));

  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // titleSpacing: 0,
          // toolbarHeight: MediaQuery.of(context).size.width < 420 ? 50.h : 65.h,
          title: SizedBox(
            height: 40.h,
            child: Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                style: text14White.copyWith(color: kColorPrimary),
                controller: searchController,
                cursorColor: kColorPrimary,
                onChanged: (value) {
                  log(value);
                  context.read<QuranSearchBloc>().add(QuranSearchLoadedEvent(value));
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: kColorWhite,
                    contentPadding: EdgeInsets.only(left: 12.sp),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.transparent)),
                    suffixIcon: BlocBuilder<QuranSearchBloc, QuranSearchState>(builder: (context, state) {
                      if (state is QuranSearchInitial) {
                        return const Icon(
                          CupertinoIcons.search,
                          color: kColorPrimary,
                        );
                      }
                      if (state is QuranSearchLoadedState) {
                        return state.isSearch
                            ? const Icon(
                                CupertinoIcons.search,
                                color: kColorPrimary,
                              )
                            : GestureDetector(
                                onTap: () {
                                  searchController.clear();
                                  context.read<QuranSearchBloc>().add(QuranSearchLoadedEvent(null));
                                },
                                child: const Icon(
                                  CupertinoIcons.clear_circled_solid,
                                  color: kColorPrimary,
                                ),
                              );
                      }
                      return const SizedBox.shrink();
                    }),
                    hintText: 'Search Quran',
                    hintStyle: text14White.copyWith(color: kColorPrimary)),
              ),
            ),
          ),

          bottom: TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorWeight: 3,
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerHeight: 0,
            padding: EdgeInsets.zero,
            labelColor: Colors.green,
            tabs: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "quran".tr(),
                    style: kStyleTextW500CW.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "bookmarked".tr(),
                    style: kStyleTextW500CW.copyWith(fontSize: 14.sp),
                  ),
                ),
              )
            ],
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: watchStream,
            builder: (context, snapshot) {
              return TabBarView(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 246, 246, 246),
                    child: BlocBuilder<QuranSearchBloc, QuranSearchState>(
                      builder: (context, state) {
                        if (state is QuranSearchInitial) {
                          return const DefaultCircularProgressIndicator();
                        } else if (state is QuranSearchLoadedState) {
                          return ListView.builder(
                            itemCount: state.filterQuranList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return surahNameCard(state.filterQuranList[index],
                                  context,int.parse(convertToEnglishNumber(state.filterQuranList[index]['id']))-1);
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 246, 246, 246),
                    child: quranBox.get('BookMark') != null && quranBox.get('BookMark').values.toList().length > 0
                        ? ListView.builder(
                            itemCount: quranBox.get('BookMark') == null ? 0 : quranBox.get('BookMark').values.toList().length,
                            itemBuilder: (BuildContext context, int index) {
                              return bookMarkWidget(firstIndex: index, surahInfo: quranBox.get('BookMark'), bookMarkSurahInfo: quranBox.get('BookMark').values.toList()[index], surahIndex: quranBox.get('BookMark').values.toList()[index]['surahIndex'], context: context);
                            },
                          )
                        : Center(
                            child: Text(
                              'there_is_no_bookmark'.tr(),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
