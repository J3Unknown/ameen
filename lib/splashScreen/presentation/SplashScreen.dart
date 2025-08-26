import 'dart:async';

import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: AppSizes.s3), () => _navigateAfterSplash(),);
    super.initState();
  }

  void _navigateAfterSplash(){
    if(AppConstants.isGuest || AppConstants.isAuthenticated){
      Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false);
    } else if(AppConstants.isRepresentativeAuthenticated) {
      Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.representativeHome)), (route) => false);
    }else {
      Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.languageScreen)), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.DEEP_BLUE,
      body: SizedBox.expand(child: Image.asset(AssetsManager.splashLogo, fit: BoxFit.contain, width: double.infinity,),)
    );
  }
}
