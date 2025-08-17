import 'package:ameen/auth/otp_screen/data/otp_arguments.dart';
import 'package:flutter/widgets.dart';

abstract class OtpReasonInterface{
  OtpArguments? otpArguments;
  void onSuccess(BuildContext context, {String? token});
  Future<void> afterOtpValidation(BuildContext context, {String? otp});
  Future<void> request(BuildContext context);
}