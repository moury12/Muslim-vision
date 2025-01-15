import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/home_bloc/prohibited-prayer-bloc/prohibeted_prayer_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class ProhibitedPrayerTimeWidget extends StatefulWidget {
  const ProhibitedPrayerTimeWidget({
    super.key,
  });

  @override
  State<ProhibitedPrayerTimeWidget> createState() => _ProhibitedPrayerTimeWidgetState();
}

class _ProhibitedPrayerTimeWidgetState extends State<ProhibitedPrayerTimeWidget> {
  @override
  void initState() {
    context.read<ProhibetedPrayerBloc>().add(ProhibetedPrayerLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProhibetedPrayerBloc, ProhibetedPrayerState>(
      builder: (context, state) {
        if (state is ProhibetedPrayerInitial) {
          return const Center(
            child: DefaultCircularProgressIndicator(),
          );
        }
        if (state is ProhibetedPrayerNoLocationState) {
          return const SizedBox.shrink();
        }
        if (state is ProhibetedPrayerLoadedState) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(state.isProhibited!.any((element) {
                  return element == true;
                })
                    ? 'assets/images/prohibited_time.png'
                    : salatTracker),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        scrollable: true,
                        content: Text(
                            'সালাতের নিষিদ্ধ সময় বিষয়ে জ্ঞাতব্য ইসলামী শরীয়তে ৩ টি সময়ে সালাত আদায় নিষিদ্ধ। আসর ও সূর্যাস্তের ব্যতিক্রম সহ নিষিদ্ধ সময় নির্ণয়ের পদ্ধতি ও মাসআলা নিম্নে তুলে ধরা হলোঃ\n(১) সূর্যোদয়ের সময়ঃ সূর্য ওঠা শুরু করার সময় থেকে পরিপূর্ণ ভাবে উদয় হওয়ার শেষ হওয়া পর্যন্ত। অ্যাপে এই নিষিদ্ধ সময়ের ব্যাপ্তিকাল ১৫ মিনিট দেখানো হয়েছে।\n(২) দ্বিপ্রহর বা মধ্যাহ্নের সময়ঃ এই সময়টি যুহরের ওয়াক্ত শুরুর আগের ৩ মিনিট। কিন্তু বাড়তি সতর্কতার জন্য ইসলামিক ফাউন্ডেশন থেকে যুহরের ওয়াক্ত শুরুর আগের ৬ মিনিট নিষিদ্ধ সময় হিসাবে দেখাতে বলা হয়েছে'
                            '\n(৩) সূর্যাস্তের সময়ঃ সূর্য অস্ত যাওয়া শুরুর সময় থেকে সূর্য পরিপূর্ণ ভাবে অস্তমিত হওয়া পর্যন্ত। অ্যাপে এই নিষিদ্ধ সময়ের ব্যাপ্তিকাল ১৫ মিনিট দেখানো হয়েছে। কোনো কারণবশতঃ ঐ দিনের আসরের সালাত পড়া না হয়ে থাকলে, সূর্যাস্তের নিষিদ্ধ সময়ের মধ্যে শুধুমাত্র ঐ দিনের আসরের সালাতটিই পড়া যাবে। তাই অ্যাপে সূর্যাস্তের নিষিদ্ধ সময়কেও আসরের সালাতের ওয়াক্ত হিসাবে দেখানো হয়েছে। কিন্তু সালাত এরকম দেরি করে পড়া মোটেই উচিত নয়। নিষিদ্ধ সময়ের ব্যাপারে বিস্তারিত জানতে অ্যাপের দ্রষ্টব্য পেজটি দেখুন। প্রসঙ্গত উল্লেখ্যঃ বিগত সময়ে সূর্যোদয় ও সূর্যাস্তের নিষিদ্ধ সময় ২৩ মিনিট ধরা হত। কিন্তু বর্তমান কালের আধুনিক ও বৈজ্ঞানিক গবেষণার পর আলেমগণ ফতোয়া দিয়েছেনঃ এই সময়ের ব্যাপ্তি কোনো ভাবেই ১৫ মিনিটের বেশি নয়। তাই আমাদের অ্যাপে নিষিদ্ধ সময় ২৩ মিনিটের পরিবর্তে ১৫ মিনিট দেখানো হয়েছে।'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.sp).copyWith(bottom: 0),
                    child: Row(
                      children: [
                        Text(
                          'prohibitedtime'.tr(),
                          style: kStyleTextW600CW.copyWith(fontSize: 12.sp),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: kColorWhite,
                          size: 14.0.w,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                    margin: EdgeInsets.all(8.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0).r,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Column(
                        children: [
                          ...List.generate(state.prohibitedPrayerList.length, (index) {
                            final time = state.prohibitedPrayerList[index];
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(time['details']),
                                  ),
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: state.isProhibited![index] ? const Color(0xffa71b1b) : kColorPrimary),
                                        padding: EdgeInsets.all(4.sp),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          time['icon'],
                                          color: kColorWhite,
                                          size: 15.sp,
                                        ),
                                      ),
                                      index == state.prohibitedPrayerList.length - 1
                                          ? const SizedBox.shrink()
                                          : Container(
                                              height: 8.h,
                                              width: 2.w,
                                              color: state.isProhibited![index] ? const Color(0xffa71b1b) : kColorPrimary,
                                            )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(time['waqtName'].toString().tr(), style: kStyleTextW500CB.copyWith(fontSize: 12.sp)),
                                  const Spacer(),
                                  Text(context.locale.toString() == 'en' ? '${time['waqtTime'].toString()} - ${DateFormat('h:mm a').format(time['waqtTimeLeft']).toString()}' : convertToBanglaNumber('${time['waqtTime'].toString()} - ${DateFormat('h:mm a').format(time['waqtTimeLeft']).toString()}'),
                                      style: kStyleTextW400CB.copyWith(fontSize: 10.sp)),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ))
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
