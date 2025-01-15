// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'zakat_screen_bloc.dart';

@immutable
abstract class ZakatScreenEvent {}
class GetCurrencyEvent extends ZakatScreenEvent {
  final String currency;
  final String code;
  GetCurrencyEvent({
    required this.currency,
    required this.code,
  });
  
}
class ZakatNisabUpdateAtNisabAmountEvent extends ZakatScreenEvent {
  final String nisaabUpdateData;
  final String nisaabAmount;
  ZakatNisabUpdateAtNisabAmountEvent({
     required this.nisaabUpdateData,
     required this.nisaabAmount,
  });
  
}
class ZakatCalculationEvent extends ZakatScreenEvent {

 final double goldValue;
 final double silverValue;
 final double bankValue;
 final double depositeValue;
 final double givernOutValue;
 final double busnessInvesmentValue;
 final double borrowedValue;
 final double dueEmployesValue;
 final double texRentValue;
 final double texnisaabAmount;
  ZakatCalculationEvent({
    required this.goldValue,
    required this.silverValue,
    required this.bankValue,
    required this.depositeValue,
    required this.givernOutValue,
    required this.busnessInvesmentValue,
    required this.borrowedValue,
    required this.dueEmployesValue,
    required this.texRentValue,
    required this.texnisaabAmount,

  });


  
}

