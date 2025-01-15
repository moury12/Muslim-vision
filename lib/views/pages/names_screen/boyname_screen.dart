// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim_vision/models/name_model.dart';

class BoyNameScreen extends StatefulWidget {
  final List<NameList> boysName;
  const BoyNameScreen({Key? key, required this.boysName}) : super(key: key);

  @override
  State<BoyNameScreen> createState() => _BoyNameScreenState();
}

class _BoyNameScreenState extends State<BoyNameScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.boysName.isEmpty
        ?  Center(child: Text('there_is_no_data'.tr(),style: TextStyle(fontSize: 14.sp),))
        : ListView.builder(
            itemCount: widget.boysName.length,
            itemBuilder: (context, index) {
              if (_hasNonEmptyData(widget.boysName[index])) {
                return Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      border: Border.all(color: const Color(0xffE2E2E2)),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          shape: const Border(
                            bottom: BorderSide(
                              color: Color(0xffE2E2E2),
                            ),
                          ),
                          tileColor: const Color(0xffFAFAFA),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.boysName[index].nameInBangla
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.5.sp,
                                    color: const Color(0xff0FAD74),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/male.svg',
                                height: 30,
                                width: 10,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          tileColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Column(
                            children: [
                              _buildRow('অর্থ',
                                  widget.boysName[index].meaningInBangla),
                              _buildRow('ইংরেজি',
                                  widget.boysName[index].nameInEnglish),
                              _buildRow(
                                  'আরবী', widget.boysName[index].nameInArabic),
                              _buildRow(
                                  'নোট', widget.boysName[index].noteInBangla),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox(); // Return an empty widget if there is no non-empty data
              }
            },
          );
  }

  Widget _buildRow(String label, String? value) {
    if (value == null || value == '' || value == '-') {
      return const SizedBox();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(label)),
        const Text(':   '),
        Expanded(
          flex: 8,
          child: Text(
            value,
            style:
                const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  bool _hasNonEmptyData(NameList data) {
    return data.nameInBangla != null &&
            data.nameInBangla != '' &&
            data.nameInBangla != '-' ||
        data.meaningInBangla != null &&
            data.meaningInBangla != '' &&
            data.meaningInBangla != '-' ||
        data.nameInEnglish != null &&
            data.nameInEnglish != '' &&
            data.nameInEnglish != '-' ||
        data.nameInArabic != null &&
            data.nameInArabic != '' &&
            data.nameInArabic != '-' ||
        data.noteInBangla != null &&
            data.noteInBangla != '' &&
            data.noteInBangla != '-';
  }
}
