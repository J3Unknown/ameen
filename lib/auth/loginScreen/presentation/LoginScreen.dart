import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utill/local/shared_preferences.dart';
import '../../../utill/shared/BaseComponent.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isEyeVisible = false;

  @override
  void dispose() {
   _phoneNumberController.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final screenHeight = AppConstants.screenSize(context).height;
  final screenWidth = AppConstants.screenSize(context).width;
    return Scaffold(
      backgroundColor: ColorsManager.GREY1,
      body: SafeArea(
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
                  //TODO: convert into button and make it change between consumer and delivery login
                  SvgPicture.asset(
                    fit: BoxFit.contain,
                    width: AppSizesDouble.s40,
                    AssetsManager.deliveryMotorcycle
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async{
                      await CacheHelper.saveData(key: KeysManager.isAuthenticated, value: false);
                      await CacheHelper.saveData(key: KeysManager.isGuest, value: true);
                      Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false);
                    },
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.translate(StringsManager.userLogin), style: Theme.of(context).textTheme.labelLarge),
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
                              } else if(value.length < AppSizes.s8){
                                return AppLocalizations.translate(StringsManager.phoneNumberRangeError);
                              }
                              return null;
                            },
                            maxLength: AppSizes.s8,
                          ),
                          SizedBox(height: AppSizesDouble.s5),
                          DefaultTextInputField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hint: StringsManager.passwordHint,
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
                              onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.forgotPassword))), //TODO: create forgot password screen
                              child: Text(AppLocalizations.translate(StringsManager.forgotPassword), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.COLUMBIA_BLUE),)
                            ),
                          ),
                          DefaultButton(
                            title: StringsManager.login,
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                //TODO: link with login action
                              }
                            },
                            isLoading: false,
                          ),
                          DefaultTextWithTextButton(
                            title: StringsManager.dontHaveAccount,
                            buttonTitle: StringsManager.register,
                            onButtonPressed: () => Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.signUp)), (route) => route.settings.name == Routes.languageScreen),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

