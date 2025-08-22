import 'dart:developer';

import 'package:ameen/Repo/otp_reason_interface.dart';
import 'package:ameen/auth/cubit/auth_cubit_state.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utill/local/localization/app_localization.dart';
import '../../../utill/shared/BaseComponent.dart';
import '../../../utill/shared/assets_manager.dart';
import '../../../utill/shared/constants_manager.dart';
import '../../../utill/shared/icons_manager.dart';
import '../../../utill/shared/strings_manager.dart';
import '../../../utill/shared/values_manager.dart';
import '../../cubit/auth_cubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.otpReasonInterface});
  final OtpReasonInterface otpReasonInterface;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late bool isRegisterOtp;
  late OtpReasonInterface otpReasonInterface;
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final AuthCubit _authCubit;
  @override
  void initState() {
    _authCubit = AuthCubit.get(context);
    otpReasonInterface = widget.otpReasonInterface;
    _authCubit.initializeStream();
    _authCubit.timer();
    _sendVerificationCode();
    super.initState();
  }

  void _sendVerificationCode(){
    otpReasonInterface.request(context);
    _authCubit.timer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = AppConstants.screenSize(context).height;
    return Scaffold(
      backgroundColor: ColorsManager.GREY1,
      body: BlocConsumer<AuthCubit, AuthCubitStates>(
        listener: (context, state) {
          if(state is AuthRegisterSuccessState){
            otpReasonInterface.onSuccess(context, token: state.profileDataModel.token);
          } else if(state is AuthRegisterErrorState){
            showDialog(context: context, builder: (context) => NoteDialog(note: state.message));
          }
        },
        builder: (context, state) => SafeArea(
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
                    child: Center(child: Image.asset(AssetsManager.otpImage, fit: BoxFit.contain, width: AppSizesDouble.s270,)) //TODO: get the OTP image
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                    height: screenHeight / AppSizesDouble.s2_5,
                    decoration: BoxDecoration(
                      color: ColorsManager.WHITE,
                      borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.translate(StringsManager.pleaseEnterTheCode), style: Theme.of(context).textTheme.labelLarge),
                          SizedBox(height: AppSizesDouble.s15,),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                            decoration: BoxDecoration(
                              color: ColorsManager.WHITE,
                              borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                              border: Border.all(color: ColorsManager.BLACK)
                            ),
                            child: Form(
                              key: _formKey,
                              child: PinCodeTextField(
                                appContext: context,
                                autoFocus: true,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  fieldHeight: AppSizesDouble.s60,
                                  fieldWidth: AppSizesDouble.s45,
                                  inactiveColor: ColorsManager.GREY,
                                  selectedColor: ColorsManager.PRIMARY_COLOR,
                                ),
                                length: AppSizes.s4,
                                keyboardType: TextInputType.number,
                                controller: _otpController,
                                validator: (value) {
                                  if (_otpController.text.length != AppSizes.s4) {
                                    return AppLocalizations.translate(StringsManager.validOtpMessage);
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizesDouble.s15,),
                          Align(
                            alignment: Alignment.center,
                            child: StreamBuilder(
                              stream: _authCubit.timerStream,
                              builder: (context, snapShot){
                                return Text('${_authCubit.counter}', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.PRIMARY_COLOR, fontWeight: FontWeight.bold),);
                              }
                            ),
                          ),
                          SizedBox(height: AppSizesDouble.s15,),
                          DefaultButton(
                            title: StringsManager.confirm,
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                if(_authCubit.otpCode == int.parse(_otpController.text)){
                                  otpReasonInterface.afterOtpValidation(context, otp: _otpController.text);
                                } else {
                                  showSnackBar(context, StringsManager.theOtpCodeIsIncorrect);
                                }
                              }
                            },
                            isLoading: false,
                          ),
                          DefaultTextWithTextButton(
                            title: StringsManager.notReceivedYet,
                            buttonTitle: StringsManager.sendAgain,
                            onButtonPressed: () => _authCubit.canResendCode? _sendVerificationCode():null,
                            buttonColor: !_authCubit.canResendCode?ColorsManager.DARK_GREY:ColorsManager.RED,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
