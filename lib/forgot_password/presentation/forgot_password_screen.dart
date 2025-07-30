import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/assets_manager.dart';
import '../../utill/shared/colors_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/icons_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController _phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
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
                  child: Center(child: Image.asset(AssetsManager.forgotPasswordImage, fit: BoxFit.contain, width: AppSizesDouble.s270,))
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.translate(StringsManager.forgotPassword), style: Theme.of(context).textTheme.labelLarge),
                        SizedBox(height: AppSizesDouble.s15,),
                        DefaultTextInputField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          hint: 'xxxx xxxx',
                          title: StringsManager.whatsappNumber,
                          isRequired: true,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                            }
                            return null;
                          },
                          maxLength: AppSizes.s8,
                        ),
                        SizedBox(height: AppSizesDouble.s35),
                        DefaultButton(
                          title: StringsManager.next,
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              //TODO: link with otp send action

                            }
                          },
                          isLoading: false,
                        ),
                      ],
                    ),
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
