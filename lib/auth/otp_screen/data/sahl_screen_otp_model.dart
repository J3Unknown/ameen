import 'package:ameen/Repo/otp_reason_interface.dart';
import 'package:ameen/Repo/repo.dart';
import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/auth/otp_screen/data/otp_arguments.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class SahlScreenOtpModel implements OtpReasonInterface{
  @override
  OtpArguments? otpArguments;

  @override
  Future<void> afterOtpValidation(BuildContext context, {String? otp}) async {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.sahl)));
  }

  @override
  void onSuccess(BuildContext context, {String? token}) {
    Repo.profileDataModel!.sahl = true;
  }

  @override
  Future<void> request(BuildContext context) async{
    AuthCubit.get(context).getSahlOtp();
  }
  
}