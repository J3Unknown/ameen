import 'package:ameen/languagePage/presentation/LanguagePage.dart';
import 'package:flutter/material.dart';

import '../../splashScreen/presentation/SplashScreen.dart';

class Routes{
  static const String splashScreen = '/';
  static const String languageScreen = '/languageScreen';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String itemDelivery = '/itemDelivery';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment/success';
  static const String paymentFailed = '/payment/failed';
  static const String orderTracking = '/orderTracking';
  static const String orderCancellation = '/orderCancellation';
  static const String orderReporting = '/orderReporting';
  static const String profile = '/profile';
  static const String support = '/support';
  static const String civilIdCheck = '/civilIdCheck';
  static const String sahl = '/sahl';
  static const String sahlRequest = '/sahl/request';
  static const String aboutUs = '/aboutUs';
  static const String termsAndConditions = '/termsAndConditions';
}

class RoutesGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashScreen:
        return  MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.languageScreen:
        return  MaterialPageRoute(builder: (_) => LanguagePage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('no route found'),
          ),
          body: const Center(child: Text('no route found')),
        )
    );
  }
}
