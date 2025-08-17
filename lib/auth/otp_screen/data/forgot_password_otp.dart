import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/auth/otp_screen/data/otp_arguments.dart';
import 'package:ameen/Repo/otp_reason_interface.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:flutter/material.dart';

class ForgotPasswordOtp implements OtpReasonInterface{

  @override
  OtpArguments? otpArguments;

  ForgotPasswordOtp(this.otpArguments);


  @override
  void onSuccess(BuildContext context, {String? token}) => Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.login)), (route) => false);

  @override
  Future<void> request(BuildContext context) async => AuthCubit.get(context).sendOtpForgotPassword(otpArguments!.phone!);


  @override
  Future<void> afterOtpValidation(BuildContext context, {String? otp}) async{}
  
}