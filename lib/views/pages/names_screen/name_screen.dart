// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/names_bloc/names_bloc.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';
import 'package:muslim_vision/views/pages/names_screen/girlsname_screen.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../../themes/light_theme. dart.dart';
import 'boyname_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final bloc = NamesBloc();

  @override
  void initState() {
    bloc.add(InitialNameLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar("names".tr(), true, [], kStyleTextW500CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 50, // Set the desired height for the search and filter buttons
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          bloc.add(SearchEvent(searchTerm: value));
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: kColorPrimary)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: kColorPrimary)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x000026323D1A),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: 'search'.tr(),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorWeight: 1,
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.green,
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return kColorPrimary.withOpacity(.1);
                          }
                          return kColorPrimary.withOpacity(.1);
                        },
                      ),
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'boy_name'.tr(),
                            textAlign: TextAlign.center,
                            style: kStyleTextW600CP,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "girl_name".tr(),
                            textAlign: TextAlign.center,
                            style: kStyleTextW600CP,
                          ),
                        ),
                      ],
                    ),
                    // TabBarView
                    Expanded(
                      child: BlocBuilder<NamesBloc, NamesState>(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is InitialNameLoadedState) {
                            return TabBarView(
                              // controller:
                              // controller: _tabController,

                              children: [
                                // Boys Names Screen
                                BoyNameScreen(
                                  boysName: state.boysName,
                                ),

                                // Girls Names Screen
                                GirlNameScreen(
                                  girlsName: state.girlsName,
                                )
                              ],
                            );
                          } else if (state is NameLoadingState) {
                            return const Center(
                              child: DefaultCircularProgressIndicator(),
                            );
                          }
                          return const Center(
                            child: DefaultCircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
