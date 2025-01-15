import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/all_doa_bloc/doa_screen_bloc/doa_screen_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/doa_screen/doa_widgets/widgets/category_title_details.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

class AllDoasCategories extends StatefulWidget {
  const AllDoasCategories({super.key});

  @override
  State<AllDoasCategories> createState() => _AllDoasCategoriesState();
}

class _AllDoasCategoriesState extends State<AllDoasCategories> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DoaScreenBloc>(context).add(DoaScreenLoadedEvent());
  }

  List<String> imgs = [
    morning_evening,
    home_family,
    prayer_doa,
    praising_allaha,
    travel,
    hajj_umrah,
    sickness_death,
    joy_distress,
    nature,
    god_etquette,
    nature,
    sickness_death,
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoaScreenBloc, DoaScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DoaScreenLodingState) {
          return const Center(child: DefaultCircularProgressIndicator());
        } else if (state is DoaScreenLodedState) {
          return Column(
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // You can adjust the number of columns as needed
                        childAspectRatio: 2 / 1.2),
                    itemCount: state.doaList.length,
                    itemBuilder: (context, index) {
                      final item = state.doaList[index];

                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => Navigator.of(context).push(CustomPageRoute(
                          child: DoasCatgoryTitle(
                            data: item.subCategories,
                            title: item.categoryInBangla,
                            cindex: index,
                          ),
                          direction: AxisDirection.left,
                        )),
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Container(
                            decoration: BoxDecoration(color: index % 2 == 0 ? kColorOlive : kColorlightYellow, border: Border.all(color: index % 2 == 0 ? kColorPrimary : kColorDeepLightYellow), borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.categoryInBangla.toString(),
                                    style: kStyleTextW600CB.copyWith(fontSize: 12.sp),
                                  ),
                                  Text(
                                    '${context.locale.toString() == 'en' ? item.subCategories.length : convertToBanglaNumber(item.subCategories.length.toString())} ${'dua'.tr()}',
                                    style: kStyleTextW500CB.copyWith(fontSize: 10.sp),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: VectorGraphic(
                                            width: 40.w,
                                            height: 40.h,
                                            fit: BoxFit.fill,
                                            loader: AssetBytesLoader(
                                              '${imgs[index]}.vec',
                                            ),
                                          )

                                          // SvgPicture.asset(
                                          //   imgs[index],
                                          //   height: 40.h,
                                          //   width: 40.w,
                                          //   fit: BoxFit.fill,
                                          // ),
                                          )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Text('Something worng');
        }
      },
    );
  }
}
