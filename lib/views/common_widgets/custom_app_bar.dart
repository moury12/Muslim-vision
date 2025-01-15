import 'package:flutter/material.dart';

AppBar customAppBar(String title, bool centerTitle, List<Widget> widgetList,
    TextStyle textStyle, BuildContext context, Function() popfunctin,
    {bool showLeading = true}) {
  return AppBar(
    leading: showLeading
        ? IconButton(
            onPressed: () => popfunctin(), icon: const Icon(Icons.arrow_back))
        : null,
    title: Text(
      title,
      // style: kStyleTextW500CW.copyWith(fontSize: 10.sp),
      style: textStyle,
    ),
    centerTitle: centerTitle,
    elevation: 0,
    actions: widgetList,
  );
}
