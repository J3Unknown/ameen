import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../otp_screen/data/otp_arguments.dart';
import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/assets_manager.dart';
import '../../utill/shared/colors_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/icons_manager.dart';
import '../../utill/shared/routes_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isEyeVisible = false;

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
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(IconsManager.backButton)
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false),
                    child: Text(AppLocalizations.translate(StringsManager.skip), style: TextStyle(color: ColorsManager.BLACK),)
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppPaddings.p20 ),
                child: SizedBox(
                  height: screenHeight / AppSizes.s3,
                  child: Center(child: SvgPicture.asset(AssetsManager.registerImage, fit: BoxFit.contain,)),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                  height: screenHeight / AppSizesDouble.s1_8,
                  decoration: BoxDecoration(
                    color: ColorsManager.WHITE,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.translate(StringsManager.createAccount), style: Theme.of(context).textTheme.labelLarge),
                          SizedBox(height: AppSizesDouble.s15,),
                          DefaultTextInputField(
                            controller: _nameController,
                            title: StringsManager.name,
                            isRequired: true,
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppSizesDouble.s15),
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
                          DefaultTextInputField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            title: StringsManager.email,
                            isRequired: true,
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppSizesDouble.s15),
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
                          SizedBox(height: AppSizesDouble.s25,),
                          DefaultButton(
                            title: StringsManager.next,
                            onPressed: () {
                              Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.otp, arguments: OtpArguments(true))));
                            }, //TODO: link with register action
                            isLoading: false,
                          ),
                          DefaultTextWithTextButton(
                            title: StringsManager.alreadyHaveAccount,
                            buttonTitle: StringsManager.login,
                            onButtonPressed: () => Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.login)), (route) => route.settings.name == Routes.languageScreen),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
