import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/auth/cubit/auth_cubit_state.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isUser = true;

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
      body: BlocConsumer<AuthCubit, AuthCubitStates>(
        listener: (context, state) async{
          if(state is AuthLoginErrorState){
            showSnackBar(context, 'Check you credentials and sign in again');
          }
          if(state is AuthLoginSuccessState){
            if(isUser){
              await saveCaches(isAuthenticated: true, token: state.profileDataModel.token!);
              Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false);
            } else {
              await saveCaches(isRepresentative: true, token: state.profileDataModel.token!);
              Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.representativeHome)), (route) => false);
            }
          }
        },
        builder: (context, state) => SafeArea(
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
                    DefaultRoundedIconButton(
                      iconColored: false,
                      hasBorder: false,
                      onPressed: () {
                        setState(() {
                          isUser = !isUser;
                        });
                      },
                      isSvg: true,
                      svgIcon: isUser? AssetsManager.deliveryMotorcycle:AssetsManager.userTopLoginIcon,
                    ),
                    if(isUser)
                    Spacer(),
                    if(isUser)
                    TextButton(
                      onPressed: () async{
                        await saveCaches(isGuest: true);
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
                    child: Center(child: SvgPicture.asset(isUser?AssetsManager.loginImage:AssetsManager.representativeLoginIcon, fit: BoxFit.contain,))
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
                            if(isUser)
                            Text(AppLocalizations.translate(StringsManager.userLogin), style: Theme.of(context).textTheme.labelLarge),
                            if(!isUser)
                            Text(AppLocalizations.translate(StringsManager.representativeLogin), style: Theme.of(context).textTheme.labelLarge),
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
                                // else if(value.length < AppSizes.s8){
                                //   return AppLocalizations.translate(StringsManager.phoneNumberRangeError);
                                // }
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
                              title: StringsManager.password,
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                                } else if(value.length < AppSizes.s8){
                                  return AppLocalizations.translate(StringsManager.passwordLengthMessage);
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.forgotPassword)),),
                                child: Text(AppLocalizations.translate(StringsManager.forgotPassword), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.COLUMBIA_BLUE),)
                              ),
                            ),
                            DefaultButton(
                              title: StringsManager.login,
                              onPressed: () async{
                                if(_formKey.currentState!.validate()) {
                                  if(isUser){
                                    AuthCubit.get(context).login(_phoneNumberController.text, _passwordController.text);
                                  } else {
                                    AuthCubit.get(context).representativeLogin(_phoneNumberController.text, _passwordController.text);
                                  }
                                }
                              },
                              isLoading: state is AuthLoginLoadingState,
                            ),
                            if(isUser)
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
      ),
    );
  }
}

