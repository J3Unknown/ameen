import 'package:ameen/Repo/otp_reason_interface.dart';
import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:flutter/material.dart';

import 'otp_arguments.dart';

class RegistrationOtpModel implements OtpReasonInterface{

  @override
  OtpArguments? otpArguments;

  RegistrationOtpModel(this.otpArguments);

  @override
  void onSuccess(BuildContext context, {String? token}) {
    Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false);
    saveCaches(isAuthenticated: true, token: token!);
  }
  @override
  Future<void> afterOtpValidation(BuildContext context, {String? otp}) async {
    assert(otpArguments != null && (otpArguments!.phone != null || otpArguments!.name != null && otpArguments!.password != null || otpArguments!.email != null));
    AuthCubit.get(context).register(otpArguments!.phone!, otpArguments!.password!, otpArguments!.name!, otpArguments!.email!, otp!);
  }
  @override
  Future<void> request(BuildContext context) async{
    AuthCubit.get(context).sendOtpRegister(otpArguments!.phone!);
  }


}