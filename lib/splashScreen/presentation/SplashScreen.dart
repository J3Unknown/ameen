import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/shared/colors_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsManager.PRIMARY_COLOR,
        child:Center(child: Text("AMEEN",style:TextStyle(fontSize:22.sp,color: ColorsManager.WHITE)))
      )
    );
  }
}
