import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';

class TasbeehScreenCustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int? maxLines;
  final double? fontSize;
  final Widget? serchIcon;
  final Color? borderColor;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final Function(String e)? onChanged;

  const TasbeehScreenCustomTextField({super.key, required this.hintText, required this.controller, this.maxLines, this.onChanged, this.fontSize, this.serchIcon, this.textInputType, this.textInputFormatter, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.newline,

      onTapOutside: (event) => SystemChannels.textInput.invokeMethod('TextInput.hide'),
      inputFormatters: textInputFormatter ?? [],
      controller: controller,
      onChanged: onChanged,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: kStyleTextW500CB.copyWith(fontSize: fontSize?.sp ?? 13.0.sp),
      cursorColor: kColorPrimary,
      maxLines: maxLines,

      decoration: InputDecoration(
        prefixIcon: serchIcon,
        // isDense: true,

         contentPadding: EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, 0.sp),
        hintText: hintText,
        hintStyle: kStyleTextW500CG.copyWith(fontSize: 12.sp, color: borderColor??kColorGrey.withOpacity(0.6)),
        fillColor: kColorWhite,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:borderColor?? kColorGrey,
            width: 0.1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:borderColor?? kColorGrey,
            width: 0.1.w,
          ),
        ),
      ),
    );
  }
}
