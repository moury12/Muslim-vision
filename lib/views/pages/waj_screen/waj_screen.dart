// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim_vision/views/pages/waj_screen/waj_widgets/new_waj_page.dart';
import 'package:muslim_vision/views/themes/light_theme.%20dart.dart';




class WazScreen extends StatefulWidget {
  const WazScreen({super.key});


  @override
  _WazScreenState createState() => _WazScreenState();
 
  
}
class _WazScreenState extends State<WazScreen> {






  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
         appBar: AppBar(
          centerTitle: true,
          title: const Text("Waj",style: TextStyle(color:kColorWhite),),
          actions: const [Padding(
            padding: EdgeInsets.only(left:0.0),
            child: Icon(Icons.search,color: kColorWhite,),
          )],
           bottom: TabBar(
             dragStartBehavior: DragStartBehavior.down,
             tabs: [
               Text(
                 'New Waj',
                 style: kStyleTextW600CW.copyWith(fontSize: 12.sp),
               ),
               Text(
                 'Namaj',
                 style: kStyleTextW600CW.copyWith(fontSize: 12.sp),
               ),
               Text(
                 'shariah',
                 style: kStyleTextW600CW.copyWith(fontSize: 12.sp),
               ),
             ],
             indicatorColor: Colors.white,
             unselectedLabelColor: Colors.black,
             indicatorWeight: 3,
            
             indicatorPadding:EdgeInsets.symmetric(horizontal: 40.h),
             labelPadding: EdgeInsets.all(5.sp),
      
             indicatorSize: TabBarIndicatorSize.tab,
           ),
         ),
         body:   const TabBarView(
           children: [
           
             NewWajScreens(),
       
             Text("ld;jfldsakfl"), 
             Text("dsalfjdsaf")],
         ),
       ),
    );
  }
}
