import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/shared/BaseComponent.dart';

class LanguagePage extends StatefulWidget {
  final String? img;
  final List<Widget>? widgets;
  const LanguagePage({Key? key,this.img,this.widgets}) : super(key: key,);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body:BaseComponent(
      //   img:"world.png",
      //   widgets:[
      //     Text("Choose your language",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18.sp)),
      //     SizedBox(height:20.h),
      //
      //     InputContainer(
      //         widget:Row(
      //           children:[
      //             SizedBox(width:10.w),
      //             Container(
      //               width:30.w,
      //               height:30.h,
      //               decoration:BoxDecoration(
      //                 image:DecorationImage(
      //                   image:AssetImage("assets/image/arabic.png")
      //                 )
      //               )
      //             ),
      //             SizedBox(width:10.w),
      //             Text("العربية",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16.sp))
      //           ]
      //         )),
      //     SizedBox(height:30.h),
      //     InputContainer(
      //         widget:Row(
      //             children:[
      //               SizedBox(width:10.w),
      //               Container(
      //                   width:30.w,
      //                   height:30.h,
      //                   decoration:BoxDecoration(
      //                       image:DecorationImage(
      //                           image:AssetImage("assets/image/english.png")
      //                       )
      //                   )
      //               ),
      //               SizedBox(width:10.w),
      //               Text("العربية",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16.sp))
      //             ]
      //         )),
      //   ]
      // )
    );
  }
}
