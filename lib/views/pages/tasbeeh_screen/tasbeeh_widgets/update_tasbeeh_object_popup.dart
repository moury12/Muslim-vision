import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_vision/blocs/tasbeeh_screen_bloc/tasbeeh_screen_tasbeeh_animation_bloc/tasbeeh_animation_bloc.dart';
import 'package:muslim_vision/global_variable.dart';
import 'package:muslim_vision/views/pages/tasbeeh_screen/tasbeeh_widgets/tasbeeh_screen_custom_text_field.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';



class UpdateTasbeehObjectPopUp extends StatefulWidget {
  final Map singleDhikrField;
  const UpdateTasbeehObjectPopUp({
    Key? key,
    required this.singleDhikrField,
  }) : super(key: key);

  @override
  State<UpdateTasbeehObjectPopUp> createState() => _UpdateTasbeehObjectPopUpState();
}

class _UpdateTasbeehObjectPopUpState extends State<UpdateTasbeehObjectPopUp> {
  TextEditingController tasbeehController = TextEditingController();
  @override
  void initState() {

    super.initState();
    tasbeehController.text = widget.singleDhikrField['count'].toString();
  }

  @override
  void dispose() {
   
    super.dispose();
    tasbeehController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: kColorBackground,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(20).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: (deviceWidth/2.75).w,
              //height: 100.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    tasbeehController.clear();
                  },
                /*style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold)
                ),*/
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                ),

                  child: Text('cancel'.tr(),style: kStyleTextW700CP.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold),),),
            ),
            SizedBox(width: 10.w,),
            SizedBox(
              width: (deviceWidth/2.75).w,
              child: ElevatedButton(
                  onPressed: () {
                    widget.singleDhikrField['count'] = int.parse(tasbeehController.text);
                    BlocProvider.of<TasbeehAnimationBloc>(context).add(TasbeehAnimationSingleDhikrEvent(widget.singleDhikrField));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)
                  ),
                  child: Text('save'.tr())),
            ),
          ],
        )
      ],
      content: SizedBox(
        width: deviceWidth.w,
        height: (deviceHeight / 5).h,
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'update_tasbeeh_count'.tr(),
                style: kStyleTextW500CB.copyWith(fontSize: 18.sp),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TasbeehScreenCustomTextField(
                  textInputType: TextInputType.number,
                  hintText: '',
                  controller: tasbeehController,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
