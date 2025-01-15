import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/five_pillars_bloc/five_pillars_bloc.dart';
import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';
import 'package:muslim_vision/views/common_widgets/custom_card_widget.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'five_pillars_of_islam_details.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

class FivePillarsOfIslamWidgets extends StatefulWidget {
  const FivePillarsOfIslamWidgets({super.key});

  @override
  State<FivePillarsOfIslamWidgets> createState() => _FivePillarsOfIslamWidgetsState();
}

class _FivePillarsOfIslamWidgetsState extends State<FivePillarsOfIslamWidgets> {
  FivePillarsBloc fivePillarsBloc = FivePillarsBloc();
  @override
  void initState() {
    super.initState();
    fivePillarsBloc.add(FivePillarsScreenLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('five_pillars_of_islam'.tr(), true, [], kStyleTextW500CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<FivePillarsBloc, FivePillarsState>(
        bloc: fivePillarsBloc,
        builder: (context, state) {
          if (state is FivePillarsLoadedState) {
            return ListView.builder(
                itemCount: state.fivePillarsData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 8.h : 0),
                    child: CustomCardWidget(
                      fivePillarsOfIslamModel: state.fivePillarsData[index],
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: FivePillarsOfIslamDetatils(
                              fivePillarsOfIslamModel: state.fivePillarsData[index],
                            ),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
                    ),
                  );
                });
          } else {
            return const Center(
              child: DefaultCircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
