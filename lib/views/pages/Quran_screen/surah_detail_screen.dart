import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../themes/light_theme. dart.dart';

class SurahDetailScreen extends StatefulWidget {
  final List quranTextList;
  final List<List<String>> segmentList;
  final int index;
  final List translationText;
  final Map singleSurahInfo;
  const SurahDetailScreen({super.key, required this.quranTextList, required this.segmentList, required this.index, required this.translationText, required this.singleSurahInfo});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  // variables
  bool _showAppbar = true;

  // NotificationListener Widgets related Variables
  double position = 0.0;
  bool isScrollingDown = false;
  double sensitivityFactor = 20.0;

  // Scrollable Positioned Widget related Variables
  final itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          flexibleSpace: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            height: _showAppbar ? 60.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: kColorPrimary,
              child: Center(
                child: Text(
                  '${widget.singleSurahInfo["name_in_bangla"]}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels - position >= sensitivityFactor) {
              // print('Axis Scroll Direction : Up');
              position = scrollInfo.metrics.pixels;
              isScrollingDown = true;
              _showAppbar = false;
              setState(() {});
            }
            if (position - scrollInfo.metrics.pixels >= sensitivityFactor) {
              // print('Axis Scroll Direction : Down');
              position = scrollInfo.metrics.pixels;
              isScrollingDown = false;
              _showAppbar = true;
              setState(() {});
            }
            return true;
          },
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Card();
            },
          ),
        ),
      ),
    );
  }
}
