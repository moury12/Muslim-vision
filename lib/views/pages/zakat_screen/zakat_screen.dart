// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/zakat_screen_bloc/zakat_screen_bloc.dart';

import 'package:muslim_vision/database/boxes.dart';

import 'package:muslim_vision/views/common_widgets/custom_app_bar.dart';

import 'package:muslim_vision/views/pages/zakat_screen/zakat_widgets/calculate_zakat_popup.dart';

import 'package:muslim_vision/views/pages/zakat_screen/zakat_widgets/zakat_screen_customtextfeild.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

import '../home_screen/home_widgets/home_screen_top_section.dart';

class ZakatCalculateScreen extends StatefulWidget {
  const ZakatCalculateScreen({super.key});

  @override
  State<ZakatCalculateScreen> createState() => _ZakatCalculateScreenState();
}

class _ZakatCalculateScreenState extends State<ZakatCalculateScreen> {
  @override
  void initState() {
    super.initState();

    if (Boxes().zakatBox.isEmpty) {
      BlocProvider.of<ZakatScreenBloc>(context).add(ZakatNisabUpdateAtNisabAmountEvent(nisaabAmount: '0', nisaabUpdateData: ""));
      BlocProvider.of<ZakatScreenBloc>(context).add(GetCurrencyEvent(currency: "Bangladeshi Taka", code: 'BDT'.tr()));
      return;
    }
    BlocProvider.of<ZakatScreenBloc>(context).add(GetCurrencyEvent(currency: Boxes().zakatBox.get('currency').toString(), code: Boxes().zakatBox.get('code').toString()));
    BlocProvider.of<ZakatScreenBloc>(context).add(ZakatNisabUpdateAtNisabAmountEvent(
      nisaabAmount: Boxes().zakatBox.get('nisaabAmount').toString(),
      nisaabUpdateData: Boxes().zakatBox.get('nisaabUpdateDate').toString(),
    ));
  }

  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _nisabController = TextEditingController();
  final TextEditingController _goldController = TextEditingController();
  final TextEditingController _silverController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _deposigtController = TextEditingController();
  final TextEditingController _loanController = TextEditingController();
  final TextEditingController _investController = TextEditingController();
  final TextEditingController _borrowedController = TextEditingController();
  final TextEditingController _dueEmployController = TextEditingController();
  final TextEditingController _texController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currencyController.dispose();
    _nisabController.dispose();
    _goldController.dispose();
    _silverController.dispose();
    _bankController.dispose();
    _deposigtController.dispose();
    _loanController.dispose();
    _investController.dispose();
    _borrowedController.dispose();
    _dueEmployController.dispose();
    _texController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String date = Boxes().zakatBox.get('nisaabUpdateDate').toString();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: customAppBar("calculate_your_zakat".tr(), true, [], kStyleTextW500CW.copyWith(fontSize: 16.sp), context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ListTile(
            //   tileColor: kColorWhite,
            //   title: Text(
            //     "learn_more_about_zakat_and_nisaab".tr(),
            //     style: kStyleTextW400CG.copyWith(fontSize: 12.sp),
            //   ),
            //   trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: kColorGrey),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    surfaceTintColor: kColorWhite,
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            "nisaab".tr(),
                            style: kStyleTextW500CW.copyWith(color: kColorPrimary, fontSize: 14.sp),
                          )),
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Row(
                              children: [
                                Text(
                                  "select_currency".tr(),
                                  style: kStyleTextW400CG.copyWith(fontSize: 13.sp),
                                ),
                                Text(
                                  "*",
                                  style: kStyleTextW400CB.copyWith(color: Colors.red, fontSize: 10.sp),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            child: BlocBuilder<ZakatScreenBloc, ZakatScreenState>(
                              buildWhen: (previous, current) => current is ZakatScreenLoadedState,
                              builder: (context, state) {
                                if (state is ZakatScreenLoadedState) {
                                  //debugPrint('******************************');
                                  debugPrint(state.code);
                                  _currencyController.text = '${state.selectCurrency} (${state.code})';
                                  return TextField(
                                    // style: ,
                                    // textAlign: TextAlign.center,
                                    controller: _currencyController,
                                    readOnly: true,
                                    onTap: (() {
                                      showCurrencyPicker(
                                        context: context,
                                        theme: CurrencyPickerThemeData(
                                          flagSize: 25,
                                          titleTextStyle: kStyleTextW400CB,
                                          subtitleTextStyle: TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
                                          bottomSheetHeight: 500.h,
                                          backgroundColor: kColorBackground,
                                          //Optional. Styles the search field.

                                          inputDecoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                                            hintText: state.selectCurrency.toString(),
                                            hintStyle: kStyleTextW500CG.copyWith(fontSize: 11.sp),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 0.5, color: kColorGrey.withOpacity(0.3)),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 0.5, color: kColorGrey),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            fillColor: kColorLightGray,
                                            filled: true,
                                          ),
                                        ),
                                        //currencyFilter: <String>['BDT','EUR', 'GBP', 'USD', 'AUD', 'CAD', 'JPY', 'HKD', 'CHF', 'SEK', 'ILS'],
                                        onSelect: (Currency currency) {
                                          // print(currency.code);
                                          BlocProvider.of<ZakatScreenBloc>(context).add(GetCurrencyEvent(currency: currency.name, code: currency.code));

                                          BlocProvider.of<ZakatScreenBloc>(context).add(ZakatNisabUpdateAtNisabAmountEvent(nisaabAmount: '0', nisaabUpdateData: Boxes().zakatBox.get('nisaabUpdateDate').toString() == "" ? "" : Boxes().zakatBox.get('nisaabUpdateDate').toString()));
                                        },
                                        favorite: ['BDT'],
                                      );
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                                      hintText: "Bangladeshi Taka(BDT)",
                                      hintStyle: kStyleTextW500CG.copyWith(fontSize: 11.sp),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5, color: kColorGrey.withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 0.5, color: kColorGrey),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      fillColor: kColorLightGray,
                                      filled: true,
                                    ),
                                  );
                                } else {
                                  return TextField(
                                    controller: _currencyController,
                                    readOnly: true,
                                    onTap: (() {
                                      showCurrencyPicker(
                                          context: context,
                                          theme: CurrencyPickerThemeData(
                                            flagSize: 25,
                                            titleTextStyle: kStyleTextW400CB,
                                            subtitleTextStyle: TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
                                            bottomSheetHeight: 500.h,
                                            backgroundColor: kColorBackground,
                                            //Optional. Styles the search field.

                                            inputDecoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                                              hintText: "Bangladeshi Taka(BDT)",
                                              hintStyle: kStyleTextW500CG.copyWith(fontSize: 11.sp),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(width: 0.5, color: kColorGrey.withOpacity(0.3)),
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 0.5, color: kColorGrey),
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                              fillColor: kColorLightGray,
                                              filled: true,
                                            ),
                                          ),
                                          onSelect: (Currency currency) {
                                            BlocProvider.of<ZakatScreenBloc>(context).add(GetCurrencyEvent(currency: currency.name, code: currency.code));

                                            BlocProvider.of<ZakatScreenBloc>(context).add(ZakatNisabUpdateAtNisabAmountEvent(
                                              nisaabAmount: Boxes().zakatBox.get('nisaabAmount').toString(),
                                              nisaabUpdateData: Boxes().zakatBox.get('nisaabUpdateDate').toString(),
                                            ));
                                          });
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                                      hintText: "Bangladeshi Taka(BDT)",
                                      hintStyle: kStyleTextW500CG.copyWith(fontSize: 11.sp),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5, color: kColorGrey.withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 0.5, color: kColorGrey),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      fillColor: kColorLightGray,
                                      filled: true,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          BlocBuilder<ZakatScreenBloc, ZakatScreenState>(
                            buildWhen: (previous, current) => current is ZakatDateUpdateAndNisaabAmountState,
                            builder: (context, state) {
                              if (state is ZakatDateUpdateAndNisaabAmountState) {
                                // print(state.nisaab);
                                //  print(state.nisaabUpdateDate);
                                _nisabController.text = state.nisaab!;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10.w, top: 10.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                'nisaab_updated'.tr(),
                                                style: kStyleTextW400CG.copyWith(fontSize: 13.sp),
                                              ),
                                              date != ''
                                                  ? Text(
                                                      '(${state.nisaabUpdateDate})',
                                                      style: kStyleTextW400CG.copyWith(fontSize: 13.sp),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: kStyleTextW400CB.copyWith(color: Colors.red, fontSize: 10.sp),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6.0.h),
                                      child: Center(
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: _nisabController,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            suffix: Text(state.code.toString()),
                                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                                            hintText: "43,000 ${state.code}",
                                            // hintText: "Bangladeshi Taka(BDT)",
                                            hintStyle: kStyleTextW500CG.copyWith(fontSize: 11.sp),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 0.5, color: kColorGrey.withOpacity(0.3)),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(width: 0.5, color: kColorGrey),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            fillColor: kColorLightGray,
                                            filled: true,
                                          ),
                                          style: kStyleTextW600CP.copyWith(fontSize: 18.sp),
                                          onTap: () {
                                            BlocProvider.of<ZakatScreenBloc>(context).add(GetCurrencyEvent(currency: Boxes().zakatBox.get('currency').toString(), code: Boxes().zakatBox.get('code').toString()));
                                          },
                                          onChanged: (value) async => await Boxes().zakatBox.put('nisaabAmount', value),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return const DefaultCircularProgressIndicator();
                                // return Column(
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               bottom: 10.w, top: 10.w),
                                //           child: Text(
                                //             'Nisaab ()',
                                //             style: kStyleTextW400CG
                                //                 .copyWith(fontSize: 10.sp),
                                //           ),
                                //         ),
                                //         Text(
                                //           "*",
                                //           style: kStyleTextW400CB.copyWith(
                                //               color: Colors.red,
                                //               fontSize: 10.sp),
                                //         )
                                //       ],
                                //     ),
                                //     Padding(
                                //       padding: EdgeInsets.symmetric(
                                //           vertical: 6.0.h),
                                //       child: Center(
                                //         child: TextField(
                                //           textAlign: TextAlign.center,
                                //           controller: _nisabController,
                                //           decoration: InputDecoration(
                                //             contentPadding:
                                //                 EdgeInsets.symmetric(
                                //                     vertical: 0,
                                //                     horizontal: 10.w),
                                //             hintText: "43,000 BDT",
                                //             // hintText: "Bangladeshi Taka(BDT)",
                                //             hintStyle: kStyleTextW500CG
                                //                 .copyWith(fontSize: 11.sp),
                                //             enabledBorder:
                                //                 OutlineInputBorder(
                                //               borderSide: BorderSide(
                                //                   width: 0.5,
                                //                   color: kColorGrey
                                //                       .withOpacity(0.3)),
                                //               borderRadius:
                                //                   BorderRadius.circular(
                                //                       8.r),
                                //             ),
                                //             focusedBorder:
                                //                 OutlineInputBorder(
                                //               borderSide: const BorderSide(
                                //                   width: 0.5,
                                //                   color: kColorGrey),
                                //               borderRadius:
                                //                   BorderRadius.circular(
                                //                       8.r),
                                //             ),
                                //             fillColor: kColorLightGray,
                                //             filled: true,
                                //           ),
                                //           style: kStyleTextW600CP.copyWith(
                                //               fontSize: 18.sp),
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    surfaceTintColor: kColorWhite,
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              "assets".tr(),
                              style: kStyleTextW600CP.copyWith(fontSize: 14.sp),
                            ),
                          ),
                          TextFieldWithTitle(controller: _goldController, title: "value_of_gold".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _silverController, title: "Value_of_silver".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _bankController, title: "in_hand_and_in_bank_accounts".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _deposigtController, title: "deposited_for".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _loanController, title: "given_out_in_loans".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _investController, title: "business_investments_shares_saving_certificates_pensions".tr())
                        ],
                      ),
                    ),
                  ),
                  Card(
                    surfaceTintColor: kColorWhite,
                    elevation: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Text(
                              "liabilities".tr(),
                              style: kStyleTextW600CP.copyWith(fontSize: 14.sp),
                            ),
                          ),
                          TextFieldWithTitle(controller: _borrowedController, title: "borrowed_money_goods_bougth_on_credit".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _dueEmployController, title: "wages_due_to_employees".tr()),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldWithTitle(controller: _texController, title: "taxes_rent_utility_bills_due_immediately".tr()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              //padding: EdgeInsets.symmetric(vertical: 5.0.r),
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                width: double.infinity,
                child: BlocListener<ZakatScreenBloc, ZakatScreenState>(
                  listener: (context, state) {
                    if (state is ZakatCalculationState) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CalculateZakat(totalZakatAmount: state.nisaabResultAmount, code: Boxes().zakatBox.get('code').toString()),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint(double.tryParse(_goldController.text).runtimeType.toString());

                      BlocProvider.of<ZakatScreenBloc>(context).add(ZakatCalculationEvent(
                          goldValue: double.tryParse(_goldController.text) ?? 00.00,
                          silverValue: double.tryParse(_silverController.text) ?? 00.00,
                          bankValue: double.tryParse(_bankController.text) ?? 00.00,
                          depositeValue: double.tryParse(_deposigtController.text) ?? 00.00,
                          givernOutValue: double.tryParse(_loanController.text) ?? 00.00,
                          busnessInvesmentValue: double.tryParse(_investController.text) ?? 00.00,
                          borrowedValue: double.tryParse(_borrowedController.text) ?? 00.00,
                          dueEmployesValue: double.tryParse(_dueEmployController.text) ?? 00.00,
                          texRentValue: double.tryParse(_texController.text) ?? 00.00,
                          texnisaabAmount: double.tryParse(_nisabController.text) ?? 00.00));

                      BlocProvider.of<ZakatScreenBloc>(context).add(ZakatNisabUpdateAtNisabAmountEvent(nisaabAmount: _nisabController.text.toString(), nisaabUpdateData: DateFormat('dd/MM/yyyy').format(DateTime.now())));
                    },
                    child: const Text('calculate').tr(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
