import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utill/local/localization/app_localization.dart';
import '../../../utill/shared/BaseComponent.dart';
import '../../../utill/shared/constants_manager.dart';
import '../../../utill/shared/values_manager.dart';

class SahlVerificationScreen extends StatelessWidget {
  SahlVerificationScreen({super.key});
  final TextEditingController _idController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenHeight = AppConstants.screenSize(context).height;
    final screenWidth = AppConstants.screenSize(context).width;
    return Scaffold(
      backgroundColor: ColorsManager.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: ColorsManager.BACKGROUND_COLOR,
      ),
      body: SizedBox(
        height: screenHeight - MediaQuery.of(context).viewPadding.top,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(AppPaddings.p20),
              child: SizedBox(
                height: screenWidth,
                child: Center(child: SvgPicture.asset(AssetsManager.forgotPasswordImage, fit: BoxFit.contain,))
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                height: screenHeight / AppSizes.s3,
                decoration: BoxDecoration(
                  color: ColorsManager.WHITE,
                  borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.translate(StringsManager.insertIdNumber), style: Theme.of(context).textTheme.labelLarge),
                        SizedBox(height: AppSizesDouble.s15,),
                        DefaultTextInputField(
                          controller: _idController,
                          keyboardType: TextInputType.number,
                          hint: 'xxxxx xxxxx',
                          title: StringsManager.civilID,
                          isRequired: true,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                            } else if(value.length < AppSizes.s10){
                              return AppLocalizations.translate(StringsManager.phoneNumberRangeError);
                            }
                            return null;
                          },
                          maxLength: AppSizes.s10,
                        ),
                        SizedBox(height: AppSizesDouble.s20,),
                        DefaultButton(
                          title: StringsManager.send,
                          onPressed: () async{
                            if(_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => SahlVerificationAlert()
                              );
                            }
                          },
                          isLoading: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
