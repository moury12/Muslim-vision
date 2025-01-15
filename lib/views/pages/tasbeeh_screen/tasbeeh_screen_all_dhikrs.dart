// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_screen_create_new_dhikr.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_dhikr_card_widget.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import '../../../blocs/tasbeeh_screen_bloc/tasbeeh_screen_all_dhikr_bloc/tasbeeh_screen_all_dhikr_bloc.dart';
import 'tasbeeh_widgets/tasbeeh_screen_custom_text_field.dart';

class TasbeehScreenAllDhikrs extends StatefulWidget {
  const TasbeehScreenAllDhikrs({Key? key}) : super(key: key);

  @override
  State<TasbeehScreenAllDhikrs> createState() => _TasbeehScreenAllDhikrsState();
}

class _TasbeehScreenAllDhikrsState extends State<TasbeehScreenAllDhikrs> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        'all_dhikirs'.tr(),
        true,
        [],
        kStyleTextW500CW.copyWith(fontSize: 16.sp),
        context,
        () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorWhite,
                minimumSize: Size(double.infinity, 0.h),
                padding: EdgeInsets.symmetric(vertical: 13.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: kColorPrimary, width: 1.w),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              onPressed: () async {
                await Navigator.of(context).push(
                  CustomPageRoute(
                    child: const TasbeehScreenCreateNewDhikr(),
                    direction: AxisDirection.left,
                  ),
                );
                if (mounted) {
                  BlocProvider.of<TasbeehScreenAllDhikrBloc>(context).add(TasbeehScreenAllDhikrLoadedEvent());
                }
              },
              child: Text(
                'create_new_dhikr'.tr(),
                style: kStyleTextW700CP.copyWith(fontSize: 12.sp),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 40.h,
              child: TasbeehScreenCustomTextField(
                onChanged: (value) => BlocProvider.of<TasbeehScreenAllDhikrBloc>(context).add(TasbeehScreenAllDhikrSearchEvent(value)),
                controller: searchController,
                hintText: 'search_dhikr_here'.tr(),
                serchIcon: const Icon(Icons.search),
              ),
            ),
            SizedBox(height: 8.h),
            const Expanded(
              child: TasbeehScreenDhikrCard(),
            )
          ],
        ),
      ),
    );
  }
}
