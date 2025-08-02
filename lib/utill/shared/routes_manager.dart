import 'package:ameen/forgot_password/presentation/forgot_password_screen.dart';
import 'package:ameen/home_layout/presentation/home_layout.dart';
import 'package:ameen/item_delivery_screen/presentation/item_delivery_screen.dart';
import 'package:ameen/languagePage/presentation/LanguagePage.dart';
import 'package:ameen/order_details_screens/presentation/order_cancellation_screen.dart';
import 'package:ameen/order_details_screens/presentation/order_reporting_screen.dart';
import 'package:ameen/payment/data/payment_result_arguments.dart';
import 'package:ameen/payment/presentation/payment_result_screen.dart';
import 'package:ameen/payment/presentation/payment_screen.dart';
import 'package:flutter/material.dart';

import '../../auth/loginScreen/presentation/LoginScreen.dart';
import '../../auth/otp_screen/data/otp_arguments.dart';
import '../../auth/otp_screen/presentation/otp_screen.dart';
import '../../auth/register/presentation/register_screen.dart';
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
  static const String paymentResult = '/payment/result';
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
        return  MaterialPageRoute(builder: (_) => LanguagePage(), settings: settings);
      case Routes.login:
        return  MaterialPageRoute(builder: (_) => LoginScreen(), settings: settings);
      case Routes.signUp:
        return  MaterialPageRoute(builder: (_) => RegisterScreen(), settings: settings);
      case Routes.forgotPassword:
        return  MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.otp:
        return  MaterialPageRoute(builder: (_) => OtpScreen(arguments: settings.arguments! as OtpArguments,));
      case Routes.home:
        return  MaterialPageRoute(builder: (_) => HomeLayout());
      case Routes.itemDelivery:
        return  MaterialPageRoute(builder: (_) => ItemDeliveryScreen());
      case Routes.payment:
        return  MaterialPageRoute(builder: (_) => PaymentScreen());
      case Routes.paymentResult:
        return  MaterialPageRoute(builder: (_) => PaymentResultScreen(arguments: settings.arguments! as PaymentResultArguments,));
      case Routes.orderReporting:
        return  MaterialPageRoute(builder: (_) => OrderReportingScreen());
      case Routes.orderCancellation:
        return  MaterialPageRoute(builder: (_) => OrderCancellationScreen());
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
