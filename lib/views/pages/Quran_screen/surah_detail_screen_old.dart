import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:muslim_vision/blocs/quran_bloc/quran_theme_bloc.dart';

import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/Quran_screen/common_widgets/audio_slider.dart';
import 'package:muslim_vision/views/pages/Quran_screen/common_widgets/quran_edit_widgets.dart';
import 'package:muslim_vision/views/pages/greeting_msg_screen/wallpapers.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:ui' as ui;
import '../../../controllers/services/common_strings.dart';
import '../../common_widgets/convert_to_bangla_number.dart';
import '../../themes/light_theme. dart.dart';

class SurahDetailScreenOld extends StatefulWidget {
  final List quranTextList;
  final List<List<String>> segmentList;
  final int index;
  final List translationText;
  final Map singleSurahInfo;
  final int? jumpToIndex;
  const SurahDetailScreenOld(
      {super.key,
      required this.quranTextList,
      required this.segmentList,
      required this.index,
      required this.translationText,
      required this.singleSurahInfo,
      this.jumpToIndex});

  @override
  State<SurahDetailScreenOld> createState() => _SurahDetailScreenOldState();
}

class _SurahDetailScreenOldState extends State<SurahDetailScreenOld> {
  final quranBox = Boxes().quranBox;
  late AudioPlayer audioPlayer;
  double position = 0.0;
  int indexTime = 0;
  int colorStackIndex = -1;
  double sensitivityFactor = 20.0;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  final itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  List items = [];
  bool colorStack = false;
  Color color = const Color.fromARGB(255, 0, 171, 6);
  int highlightedJumpIndex = -1;
  List quranTexts = [];
  int indexNumber = 0;
  List<List<String>> timeBasedWords = [];
  int activeIndex = -1;
  Stream<Duration> get _positionDataStream => audioPlayer.positionStream;
  String? dropdownvalue;

  setAudioSource(int indexN) async {
    String surahNum = '00${widget.index}';
    String ayatNum = '00${indexN + 1}';
    if (widget.index == 1) {
      ayatNum = '00$indexN';
    }
    if (widget.index > 9 && widget.index < 100) {
      surahNum = '0${widget.index}';
    } else if (widget.index > 99) {
      surahNum = '${widget.index}';
    }
    if (indexN + 1 > 9 && indexN + 1 < 100) {
      ayatNum = '0${indexN + 1}';
    } else if (indexN + 1 > 99) {
      ayatNum = '${indexN + 1}';
    }
    try {
      final dmPath = Boxes().dmPath;
      final baseUrl = dmPath.get('base_url');
      await audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
        LockCachingAudioSource(
          // Uri.parse(audios[indexN]),
          //Uri.parse('http://103.119.102.117:1002/muslim-vision/assets/audio/quran-arabic/mishary-rashid-alafasy/${widget.index}/$surahNum$ayatNum'),
          Uri.parse(
              '$baseUrl/assets/audio/quran-arabic/mishary-rashid-alafasy/${widget.index}/$surahNum$ayatNum'),
          // Uri.parse(
          //     'https://verses.quran.com/Alafasy/mp3/${surahNum}${ayatNum}.mp3'
          //     ),
          // Uri.parse('https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3'),
          tag: MediaItem(
            id: '$indexN',
            album: "আয়াত: ${indexNumber + 1}",
            title: "${widget.singleSurahInfo["name_in_bangla"]}",
            artUri: Uri.parse(
                'https://images.unsplash.com/photo-1601191362988-ac6ebec629c8?q=80&w=2535&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          ),
        ),
        LockCachingAudioSource(
          // Uri.parse(audios[indexN]),
          //Uri.parse('http://103.119.102.117:1002/muslim-vision/assets/audio/quran-bangla/${widget.index}/$ayatNum'),
          Uri.parse(
              '$baseUrl/assets/audio/quran-bangla/${widget.index}/$ayatNum'),
          // Uri.parse(
          //     'https://verses.quran.com/Alafasy/mp3/${surahNum}${ayatNum}.mp3'
          //     ),
          // Uri.parse('https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3'),
          tag: MediaItem(
            id: '${indexNumber + 2}',
            album: "আয়াত: ${indexNumber + 1}",
            title: "${widget.singleSurahInfo["name_in_bangla"]}",
            artUri: Uri.parse(
                'https://images.unsplash.com/photo-1601191362988-ac6ebec629c8?q=80&w=2535&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          ),
        ),
      ]));
    } on PlatformException {
      // print('exception');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  playPositionBased(int index) async {
    audioPlayer.stop();
    audioPlayer.dispose();
    audioPlayer = AudioPlayer();
    indexNumber = index;
    activeIndex = index;
    if (mounted) {
      setState(() {});
    }
    await setAudioSource(indexNumber);

    audioPlayer.play();

    audioPlayer.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.ready) {
        // isLoading = false;
        if (mounted) {
          setState(() {});
        }
      }
      if (event.processingState == ProcessingState.completed &&
          index < widget.quranTextList.length - 1) {
        await audioPlayer.seekToNext();

        index++;
        indexNumber = index;
        activeIndex = index;
        if (mounted) {
          setState(() {});
        }
        itemScrollController.scrollTo(
            curve: Curves.easeInOut,
            index: index,
            duration: const Duration(seconds: 1));

        try {
          await setAudioSource(indexNumber);
        } on PlatformException {
          //  print('exception');
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      if (event.processingState == ProcessingState.buffering) {}
    });
  }

  void setHighlightedLastAyat() {
    setState(() {
      if (widget.jumpToIndex != 0) {
        highlightedJumpIndex = widget.jumpToIndex ?? -1;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        highlightedJumpIndex = -1;
      });
    });
  }

  double getWidthOfAyahNumber(surahIndex, ayahIndex) {
    if (surahIndex > 100 && ayahIndex > 100) {
      return 60;
    }
    if (surahIndex > 100) {
      return 50;
    }
    if (ayahIndex > 100) {
      return 50;
    }
    return 40;
  }

  void _handleScroll() {
    int currentIndex = itemPositionsListener.itemPositions.value.isNotEmpty
        ? itemPositionsListener.itemPositions.value.first.index
        : -1;
    quranBox.put('LastRead', currentIndex);
    quranBox.put('surah name', widget.singleSurahInfo["name_in_bangla"]);
  }

  @override
  void initState() {
    super.initState();

    setHighlightedLastAyat();
    timeBasedWords = widget.segmentList;
    audioPlayer = AudioPlayer();
    audioPlayer.setCanUseNetworkResourcesForLiveStreamingWhilePaused(true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (int i = 0; i < widget.quranTextList.length; i++) {
      quranTexts.add(widget.quranTextList[i]["uthmani-simple"]);
      items.add('$i');
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (widget.jumpToIndex != null && context.mounted) {
          if (widget.jumpToIndex != 0) {
            itemScrollController.scrollTo(
              curve: Curves.easeInOut,
              index: widget.jumpToIndex!,
              duration: const Duration(milliseconds: 500),
            );
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    itemPositionsListener.itemPositions.addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
    itemPositionsListener.itemPositions.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        return Theme(
          data: state.isDarkMode ? darkQuranTheme : lightQuranTheme,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            // backgroundColor: const Color.fromARGB(255, 236, 236, 236),
            appBar: _showAppbar
                ? AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    automaticallyImplyLeading: false,
                    title: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      height: _showAppbar ? 60.h : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: state.isDarkMode
                            ? darkQuranTheme.appBarTheme.backgroundColor
                            : lightQuranTheme.appBarTheme.backgroundColor,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _showAppbar
                                  ? DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        dropdownColor: state.isDarkMode
                                            ? kColorDeepGreen
                                            : Colors.white,
                                        iconEnabledColor: Colors.white,
                                        hint: dropdownvalue == null
                                            ? Text(
                                                '${widget.singleSurahInfo["name_in_bangla"]}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )
                                            : null,
                                        value: dropdownvalue,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: items
                                            .map<DropdownMenuItem<String>>(
                                                (entry) {
                                          String item = entry as String;
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                                '${'ayat'.tr()}  ${context.locale.toString() == 'en' ? '${int.parse(item) + 1}' : convertToBanglaNumber('${int.parse(item) + 1}')}'),
                                          );
                                        }).toList(),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return items.map<Widget>((item) {
                                            return Container(
                                              alignment: Alignment.centerLeft,
                                              constraints: const BoxConstraints(
                                                  minWidth: 100),
                                              child: Text(
                                                '${widget.singleSurahInfo["name_in_bangla"]}',
                                                style: TextStyle(
                                                    color: state.isDarkMode
                                                        ? Colors.white60
                                                        : Colors.white),
                                              ),
                                            );
                                          }).toList();
                                        },
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                            itemScrollController.scrollTo(
                                                curve: Curves.easeInOut,
                                                index: int.parse(newValue),
                                                duration:
                                                    const Duration(seconds: 1));
                                          });
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                        /// theme settings
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierColor: Colors.white.withOpacity(0),
                                  barrierDismissible: true,
                                  builder: (contex) {
                                    return BlocBuilder<QuranThemeBloc,
                                            QuranThemeState>(
                                        builder: (context, state) {
                                      return QuranEditDialog(
                                        progressValue: state.progressValue,
                                        darkThemeTap: () {
                                          context
                                              .read<QuranThemeBloc>()
                                              .add(ToggleTheme(true));
                                        },
                                        lightThemeTap: () {
                                          context
                                              .read<QuranThemeBloc>()
                                              .add(ToggleTheme(false));
                                        },
                                        onChange: (value) {
                                          context
                                              .read<QuranThemeBloc>()
                                              .add(UpdateFontSize(value));
                                        },
                                      );
                                    });
                                  });
                            },
                            icon: const Icon(Icons.settings_outlined))
                      ]

                    /* bottom: PreferredSize(
                    preferredSize: Size.fromHeight(30.0),
                    child: Image.asset("assets/images/bismillah.png")),*/
                    )
                : null,
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
                itemPositionsListener: itemPositionsListener,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: quranTexts.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? const SizedBox(
                              height: kToolbarHeight + kToolbarHeight - 20)
                          : const SizedBox.shrink(),
                      index == 0 &&
                              (widget.singleSurahInfo["name_in_bangla"] !=
                                      'আত-তাওবাহ্‌' &&
                                  widget.singleSurahInfo["name_in_bangla"] !=
                                      'আল ফাতিহা')
                          ? Padding(
                              padding: EdgeInsets.all(12.sp),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/bismillah.png",
                                    height: 50.h,
                                    color: state.isDarkMode
                                        ? Colors.white60
                                        : Colors.black,
                                  ),
                                  Text(
                                    'bismilah_rahim'.tr(),
                                    style: TextStyle(fontSize: 12.sp),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Container(
                        margin: EdgeInsets.all(2.w),
                        padding: EdgeInsets.fromLTRB(10.w, 5.w, 10.w, 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedJumpIndex == index
                              ? state.isDarkMode
                                  ? kColorLightDeepGreen
                                  : kColorPrimaryAccent.withOpacity(.2)
                              : index == activeIndex && audioPlayer.playing
                                  ? state.isDarkMode
                                      ? kColorLightDeepGreen
                                      : const Color.fromARGB(255, 237, 255, 238)
                                  : state.isDarkMode
                                      ? kColorLightDeepGreen
                                      : kColorSwitchInactiveGrey
                                          .withOpacity(.5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 10.w, 8.w, 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Center(
                                        child: quranBox.get('BookMark') !=
                                                    null &&
                                                quranBox
                                                    .get('BookMark')
                                                    .containsKey(
                                                        '${widget.index}:$index')
                                            ? CircleAvatar(
                                                backgroundColor: kColorGreen
                                                    .withOpacity(0.7),
                                                child: Text(
                                                  convertToBanglaNumber(
                                                      '${widget.index}:${index + 1}'),
                                                  style: TextStyle(
                                                      color: kColorWhite,
                                                      fontSize: 12.sp),
                                                ),
                                              )
                                            : Text(
                                                convertToBanglaNumber(
                                                    '${widget.index}:${index + 1}'),
                                                style: TextStyle(
                                                    color: state.isDarkMode
                                                        ? kColorPrimaryAccent
                                                        : kColorGreen,
                                                    fontSize: 12.sp),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    textDirection: ui.TextDirection.rtl,
                                    children: [
                                      for (int i = 0;
                                          i < quranTexts[index].length;
                                          i++)
                                        StreamBuilder(
                                          stream: _positionDataStream,
                                          builder: (context, snapshot) {
                                            String text2 = quranTexts[index][i];

                                            String text = '';
                                            if (snapshot.hasData) {
                                              timeBasedWords[indexNumber]
                                                  .asMap()
                                                  .forEach(
                                                (indexOfTime, value) {
                                                  final newKey = value
                                                      .toString()
                                                      .indexOf(':');
                                                  final firstKey = value
                                                      .toString()
                                                      .substring(0, newKey);
                                                  final secondKey = value
                                                      .toString()
                                                      .substring(
                                                          newKey + 1,
                                                          value
                                                              .toString()
                                                              .length);
                                                  if (snapshot.data!
                                                              .inMilliseconds >
                                                          int.parse(firstKey) &&
                                                      snapshot.data!
                                                              .inMilliseconds <
                                                          int.parse(
                                                              secondKey)) {
                                                    text =
                                                        quranTexts[indexNumber]
                                                            [indexOfTime];
                                                    indexTime = indexOfTime;
                                                  }
                                                },
                                              );
                                            }

                                            return Wrap(
                                              alignment: WrapAlignment.start,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              textDirection:
                                                  ui.TextDirection.rtl,
                                              children: [
                                                Text(
                                                  '$text2 ',
                                                  softWrap: true,
                                                  textDirection:
                                                      ui.TextDirection.rtl,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      fontFamily: 'Naskh',
                                                      fontSize: state.fontSize,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // leadingDistribution:
                                                      //     TextLeadingDistribution
                                                      //         .proportional,
                                                      color: audioPlayer
                                                                      .currentIndex ==
                                                                  0 &&
                                                              quranTexts[index]
                                                                      [i] ==
                                                                  text &&
                                                              indexNumber ==
                                                                  index &&
                                                              indexTime == i &&
                                                              quranTexts[index]
                                                                      [i]
                                                                  .toString()
                                                                  .isNotEmpty
                                                          ? Colors.red
                                                          // Color.fromARGB(
                                                          //     255, 0, 125, 56)
                                                          // Color.fromARGB(
                                                          //     255, 11, 163, 11)

                                                          // const Color.fromARGB(
                                                          //     255, 0, 171, 6)
                                                          // Color.fromARGB(
                                                          //     255, 1, 161, 1)

                                                          : state.isDarkMode
                                                              ? Colors.white60
                                                              : Colors.black),
                                                ),
                                                quranTexts[index][i] ==
                                                        quranTexts[index].last
                                                    ? Text(
                                                        CommonFunctions()
                                                            .getVerseEndSymbol(
                                                                index + 1,
                                                                arabicNumeral:
                                                                    true),
                                                        softWrap: true,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize:
                                                                state.fontSize,
                                                            fontFamily:
                                                                'QuranCommon',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: state
                                                                    .isDarkMode
                                                                ? Colors.white60
                                                                : Colors.black))
                                                    : const SizedBox.shrink(),
                                              ],
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    // height: 10,
                                    // width: 300,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'অর্থ: ${widget.translationText[index]}',
                                        textAlign: TextAlign.justify,
                                        textDirection: ui.TextDirection.ltr,
                                        style: TextStyle(
                                            leadingDistribution:
                                                TextLeadingDistribution
                                                    .proportional,
                                            fontSize: state.fontSize - 10,
                                            color: state.isDarkMode
                                                ? Colors.white60
                                                : kColorBlack),

                                        // quran.getVerseEndSymbol(1,
                                        //   arabicNumeral: true)
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          Navigator.of(context)
                                              .push(CustomPageRoute(
                                            child: Wallpapers(
                                              greetingsTitle: CommonFunctions()
                                                  .cleanText(quranTexts[index]
                                                      .toString()),
                                              greetingsImage: "",
                                              greetingsSubtitle:
                                                  widget.translationText[index],
                                            ),
                                            direction: AxisDirection.left,
                                          ));
                                        },
                                        icon: const Icon(Icons.share,
                                            color: kColorPrimary),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  '${CommonFunctions().cleanText(quranTexts[index].toString())}\n${widget.translationText[index]}'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Text copied to clipboard!")),
                                          );
                                        },
                                        icon: const Icon(Icons.copy,
                                            color: kColorPrimary),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          final existingBookMark = quranBox.get(
                                              'BookMark',
                                              defaultValue: {});
                                          final modifiedBookMark =
                                              Map.from(existingBookMark);
                                          if (modifiedBookMark.containsKey(
                                              '${widget.index}:$index')) {
                                            modifiedBookMark.remove(
                                                '${widget.index}:$index');
                                          } else {
                                            modifiedBookMark[
                                                '${widget.index}:$index'] = {
                                              'surahIndex': widget.index,
                                              'surahName':
                                                  widget.singleSurahInfo[
                                                      "name_in_bangla"],
                                              'ayatIndex': index,
                                              'ayatDetails':
                                                  widget.translationText[index]
                                            };
                                          }

                                          await quranBox.put(
                                              'BookMark', modifiedBookMark);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.bookmark,
                                          color: kColorPrimary,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          playPositionBased(index);
                                        },
                                        icon: const Icon(Icons.play_circle,
                                            color: kColorPrimary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      index == quranTexts.length - 1
                          ? const SizedBox(
                              height: kToolbarHeight + kToolbarHeight - 20)
                          : const SizedBox.shrink()
                    ],
                  );
                },
              ),
            ),
            bottomSheet: BottomSheet(
              onClosing: () {},
              builder: (context) {
                return FractionallySizedBox(
                  widthFactor:
                      MediaQuery.of(context).size.width < 500 ? 1 : 1.25,
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      color: state.isDarkMode ? kColorDeepGreen : kColorPrimary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    height: _showAppbar ? 75.h : 0,
                    duration: const Duration(milliseconds: 0),
                    child: SizedBox(
                      width: deviceWidth.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(12.sp, 12.sp, 12.sp, 12.sp),
                            child: SvgPicture.asset(audio_player),
                          ),
                          _showAppbar && audioPlayer.playing ||
                                  audioPlayer.processingState ==
                                      ProcessingState.ready
                              ? AudioSlider(
                                  audioPlayer: audioPlayer,
                                  surahInfo: {
                                    'surahName':
                                        '${widget.singleSurahInfo["name_in_bangla"]}'
                                  },
                                )
                              : AudioSliderStatic(
                                  surahInfo: {
                                    'surahName':
                                        '${widget.singleSurahInfo["name_in_bangla"]}'
                                  },
                                ),
                          const Spacer(),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                if (indexNumber > 0 &&
                                    audioPlayer.currentIndex != null) {
                                  await audioPlayer.stop();
                                  await audioPlayer.dispose();
                                  playPositionBased(indexNumber - 1);
                                  itemScrollController.scrollTo(
                                      curve: Curves.easeInOut,
                                      index: indexNumber,
                                      duration: const Duration(seconds: 1));
                                }
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                size: 40.sp,
                                color: Colors.white.withOpacity(0.69),
                              ),
                            ),
                          ),
                          audioPlayer.processingState == ProcessingState.loading
                              ? SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: kColorBlackGray,
                                    ),
                                  ),
                                )
                              : !audioPlayer.playing
                                  ? IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () async {
                                        itemScrollController.scrollTo(
                                            curve: Curves.easeInOut,
                                            index: indexNumber,
                                            duration:
                                                const Duration(seconds: 1));

                                        if (audioPlayer.currentIndex ==
                                            null /*|| audioPlayer.currentIndex==quranTexts.length*/) {
                                          playPositionBased(0);
                                          return;
                                        }
                                        await audioPlayer.play();
                                      },
                                      icon: Icon(
                                        Icons.play_circle_fill,
                                        size: 40.sp,
                                        color: kColorWhite,
                                      ),
                                    )
                                  : IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () async {
                                        await audioPlayer.pause();
                                      },
                                      icon: Icon(
                                        Icons.pause_circle_filled,
                                        size: 40.sp,
                                        color: kColorWhite,
                                      ),
                                    ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              if (indexNumber + 1 <
                                      widget.quranTextList.length &&
                                  audioPlayer.currentIndex != null) {
                                await audioPlayer.stop();
                                await audioPlayer.dispose();
                                playPositionBased(indexNumber + 1);
                                itemScrollController.scrollTo(
                                    curve: Curves.easeInOut,
                                    index: indexNumber,
                                    duration: const Duration(seconds: 1));
                              }
                            },
                            icon: Icon(
                              Icons.skip_next,
                              size: 40.sp,
                              color: Colors.white.withOpacity(0.69),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
