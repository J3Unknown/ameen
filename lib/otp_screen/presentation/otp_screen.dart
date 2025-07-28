import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/assets_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/icons_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';
import '../data/otp_arguments.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.arguments});
  final OtpArguments arguments;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late bool isRegisterOtp;

  @override
  void initState() {
    isRegisterOtp = widget.arguments.isRegisterOtp;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = AppConstants.screenSize(context).height;
    return Scaffold(
      backgroundColor: ColorsManager.GREY1,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight - MediaQuery.of(context).viewPadding.top,
          child: Stack(
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(IconsManager.backButton)
              ),
              Padding(
                padding: EdgeInsets.all(AppPaddings.p20),
                child: SizedBox(
                  height: screenHeight / AppSizesDouble.s1_8,
                  child: Center(child: SvgPicture.asset(AssetsManager.otpImage, fit: BoxFit.contain, width: AppSizesDouble.s270,))
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                  height: screenHeight / AppSizesDouble.s2_9,
                  decoration: BoxDecoration(
                    color: ColorsManager.WHITE,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.translate(StringsManager.pleaseEnterTheCode), style: Theme.of(context).textTheme.labelLarge),
                      SizedBox(height: AppSizesDouble.s15,),
                      Text('60'),
                      SizedBox(height: AppSizesDouble.s15,),
                      DefaultButton(
                        title: StringsManager.confirm,
                        onPressed: () {
                          //TODO: add otp check action
                        },
                        isLoading: false,
                      ),
                      DefaultTextWithTextButton(
                        title: StringsManager.notReceivedYet,
                        buttonTitle: StringsManager.sendAgain,
                        onButtonPressed: (){}
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
