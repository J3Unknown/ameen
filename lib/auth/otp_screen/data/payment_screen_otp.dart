import 'package:ameen/Repo/otp_reason_interface.dart';
import 'package:ameen/auth/otp_screen/data/otp_arguments.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:flutter/material.dart';

class PaymentScreenOtp implements OtpReasonInterface{
  @override
  OtpArguments? otpArguments;

  @override
  Future<void> afterOtpValidation(BuildContext context, {String? otp}) async {}

  @override
  void onSuccess(BuildContext context, {String? token}) {
    Navigator.pushReplacement(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.payment)));
  }

  @override
  Future<void> request(BuildContext context) async{}

}