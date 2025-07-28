import 'dart:async';

import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utill/shared/colors_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: AppSizes.s3), () => _navigateAfterSplash(),);
    super.initState();
  }

  void _navigateAfterSplash(){
    if(AppConstants.isGuest || AppConstants.isAuthenticated){
      Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)));
    } else {
      Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.languageScreen)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(child: Image.asset(AssetsManager.splashScreenImage, fit: BoxFit.cover,),)
    );
  }
}
