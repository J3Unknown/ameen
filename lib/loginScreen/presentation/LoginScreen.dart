import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utill/shared/BaseComponent.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEyeVisible = false;

  @override
  Widget build(BuildContext context) {
  final screenHeight = AppConstants.screenSize(context).height;
  final screenWidth = AppConstants.screenSize(context).width;
    return Scaffold(
      backgroundColor: ColorsManager.GREY,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight - MediaQuery.of(context).viewPadding.top,
            child: Stack(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(IconsManager.backButton)
                    ),
                    SvgPicture.asset(
                      fit: BoxFit.contain,
                      width: AppSizesDouble.s40,
                      AssetsManager.deliveryMotorcycle
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home))),
                      child: Text(AppLocalizations.translate(StringsManager.skip), style: TextStyle(color: ColorsManager.BLACK),)
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(AppPaddings.p20),
                  child: SizedBox(
                    height: screenWidth,
                    child: SvgPicture.asset(AssetsManager.loginImage, fit: BoxFit.contain,)
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                    height: screenHeight / AppSizes.s2,
                    decoration: BoxDecoration(
                      color: ColorsManager.WHITE,
                      borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.translate(StringsManager.userLogin),style:TextStyle(fontWeight:FontWeight.bold,fontSize:18.sp)),
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
                        SizedBox(height: AppSizesDouble.s5),
                        DefaultTextInputField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hint: '********',
                          onSuffixPressed: (){
                            setState(()  => isEyeVisible = !isEyeVisible);
                          },
                          suffixActivated: isEyeVisible,
                          suffixIconActivated: IconsManager.eyeOffIcon,
                          suffixIconInActivated: IconsManager.eyeIcon,
                          isRequired: true,
                          title: StringsManager.forgotPassword,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: (){}, //TODO: create forgot password screen
                            child: Text(AppLocalizations.translate(StringsManager.forgotPassword), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.COLUMBIA_BLUE),)
                          ),
                        ),
                        DefaultButton(
                          title: StringsManager.login,
                          onPressed: (){}, //TODO: link with login action
                          isLoading: false,
                        ),
                        DefaultTextWithTextButton(
                          title: StringsManager.dontHaveAccount,
                          buttonTitle: StringsManager.register,
                          onButtonPressed: (){}, //TODO: link with registration page
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

