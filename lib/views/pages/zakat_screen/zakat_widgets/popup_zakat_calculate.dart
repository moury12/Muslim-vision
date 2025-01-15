import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopupZakatTotalAmount extends StatefulWidget {
  String amount;

  // List<OrderModel> tableOrderData;

  PopupZakatTotalAmount({
    Key? key,
    required this.amount,

    //required this.tableOrderData
  }) : super(key: key);

  @override
  State<PopupZakatTotalAmount> createState() => PopupZakatTotalAmountState();
}

class PopupZakatTotalAmountState extends State<PopupZakatTotalAmount> {
// ---------------------------------- Firebase notification sent ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    double popUpHeight = 400.h;
    double popUpWidth = 250.w;
    return Align(
      alignment: const Alignment(-0.05, 0.05),
      child: Material(
          // color: COLOR_Grey2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: SizedBox(
            height: popUpHeight,
            width: popUpWidth,
            child: const Column(
              children: [],
            ),
          )),
    );
  }
}
