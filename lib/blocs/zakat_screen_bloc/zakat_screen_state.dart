// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'zakat_screen_bloc.dart';

@immutable
abstract class ZakatScreenState {}

  class ZakatScreenInitial extends ZakatScreenState {}

class ZakatScreenLoadedState extends ZakatScreenState {
    final String selectCurrency;
    final String code;
   

  ZakatScreenLoadedState({
    required this.selectCurrency,
    required this.code,
   
   
  });
    
  }
class ZakatDateUpdateAndNisaabAmountState extends ZakatScreenState {
     final String? nisaabUpdateDate;
  final String ?nisaab;
  final String ?code;
  ZakatDateUpdateAndNisaabAmountState({
  this.nisaabUpdateDate,
  this.nisaab,
  this.code
  });
    
  }

class ZakatCalculationState extends ZakatScreenState {
 

  final String nisaabResultAmount;
  ZakatCalculationState({
   
    required this.nisaabResultAmount,
  });

}
