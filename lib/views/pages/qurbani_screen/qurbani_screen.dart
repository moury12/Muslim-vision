import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_vision/blocs/qubani_bloc/qurbani_bloc.dart';
import 'package:muslim_vision/controllers/services/common_strings.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/common_widgets/custom_page_route_widget.dart';
import 'package:muslim_vision/views/pages/qurbani_screen/widgets/qurbani_details.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

class QurbaniScreen extends StatefulWidget {
  const QurbaniScreen({super.key});

  @override
  State<QurbaniScreen> createState() => _QurbaniScreenState();
}

class _QurbaniScreenState extends State<QurbaniScreen> {
  QurbaniBloc qurbaniBloc = QurbaniBloc();

  @override
  void initState() {
    super.initState();
    qurbaniBloc.add(QurbaniScreenLodedScerrnEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SvgPicture.asset(
                    qurbani_home,
                    fit: BoxFit.fill,
                    width: deviceWidth.w,
                    height: (deviceHeight / 4).h,
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: kColorWhite,
                        size: 20.sp,
                      ))
                ],
              )),
          Expanded(
              flex: 9,
              child: BlocBuilder<QurbaniBloc, QurbaniState>(
                bloc: qurbaniBloc,
                builder: (context, state) {
                  if (state is QurbaniLoadedState) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.qurbaniData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: index == 0 ? 8.0.h : 0),
                            child: Container(
                              // color: kColorWhite,
                              // elevation: 1,
                              margin: EdgeInsets.only(bottom: 4.w,left: 8.w,right: 8.w),
                              decoration: BoxDecoration(
                                  color: kColorWhite,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    CustomPageRoute(
                                      child: QurbaniDetatils(
                                        qurbaniModel: state.qurbaniData[index],
                                      ),
                                      direction: AxisDirection.left,
                                    ),
                                  );
                                },
                                leading: Text(
                                  '${index + 1}.',
                                  style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                                ),
                                title: Text(
                                  state.qurbaniData[index].categoryInBangla,
                                  style: kStyleTextW400CB.copyWith(fontSize: 14.sp),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14.sp,
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: DefaultCircularProgressIndicator(),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}
