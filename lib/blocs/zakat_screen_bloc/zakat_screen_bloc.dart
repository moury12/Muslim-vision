// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muslim_vision/database/boxes.dart';

part 'zakat_screen_bloc_event.dart';
part 'zakat_screen_state.dart';

class ZakatScreenBloc extends Bloc<ZakatScreenEvent, ZakatScreenState> {
  ZakatScreenBloc() : super(ZakatScreenInitial()) {
    on<ZakatScreenEvent>((event, emit) {});
    on<GetCurrencyEvent>(getCurrency); //currency

    on<ZakatNisabUpdateAtNisabAmountEvent>(nisabUpdateDateAndNisaab); //nisaab date update and Amount update

    on<ZakatCalculationEvent>(zakatCalculation); //zakat calculation
  }
  // get currency
  FutureOr<void> getCurrency(GetCurrencyEvent event, Emitter<ZakatScreenState> emit) async {
    await Boxes().zakatBox.put('currency', event.currency);
    await Boxes().zakatBox.put('code', event.code);

    emit(ZakatScreenLoadedState(selectCurrency: Boxes().zakatBox.get('currency').toString(), code: Boxes().zakatBox.get('code').toString()));
  }

  //update date and amount
  FutureOr<void> nisabUpdateDateAndNisaab(ZakatNisabUpdateAtNisabAmountEvent event, Emitter<ZakatScreenState> emit) async {
    String nisaab = event.nisaabAmount;
    String date = event.nisaabUpdateData;
    if (nisaab == '000' || nisaab == '' && date == "") {
      emit(ZakatDateUpdateAndNisaabAmountState(nisaabUpdateDate: date, nisaab: nisaab, code: "BDT"));
    } else {
      await Boxes().zakatBox.put('nisaabUpdateDate', event.nisaabUpdateData);
      await Boxes().zakatBox.put('nisaabAmount', event.nisaabAmount);
      date = Boxes().zakatBox.get('nisaabUpdateDate').toString();
      nisaab = Boxes().zakatBox.get('nisaabAmount').toString();
      emit(ZakatDateUpdateAndNisaabAmountState(nisaabUpdateDate: date, nisaab: nisaab, code: Boxes().zakatBox.get('code').toString()));
    }
  }

// zakat Calculation
  FutureOr<void> zakatCalculation(ZakatCalculationEvent event, Emitter<ZakatScreenState> emit) {
    String nisaab = Boxes().zakatBox.get('nisaabAmount').toString();

    debugPrint("Inisb xxxxxxxxxxxxx$nisaab");
    //print("nisaab:$nisaab");

    double sumAsset = event.goldValue + event.silverValue + event.bankValue + event.depositeValue + event.givernOutValue + event.busnessInvesmentValue;
    double subAsset = event.borrowedValue + event.dueEmployesValue + event.texRentValue;
    //print("sumAsset:$sumAsset");
    //print("subAsset:$subAsset");
    double totalamount = sumAsset - subAsset;
    // print("totalamount: $totalamount");

    String result = '';
    //*****************************
    double nisaabValue = event.texnisaabAmount;
    debugPrint("nisaabValue:$nisaabValue");
    if (nisaab != "0") {
      nisaabValue = double.parse(nisaab);
    } else {
      nisaabValue;
    }

    double zakat = (totalamount * 2.5) / 100;
    // print("zakat:$zakat");
    //*****************************

    if (totalamount >= nisaabValue) {
      result = zakat.toStringAsFixed(2).toString();
    } else {
      result = "your_amount_not_allowed_for_zakat".tr();
    }

    // print(ZakatCalculationState(nisaabResultAmount: result));

    emit(ZakatCalculationState(nisaabResultAmount: result));
  }
}
