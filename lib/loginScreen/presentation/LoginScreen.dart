import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: AppBar(
        backgroundColor: ColorsManager.GREY,
        leading: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(IconsManager.backButton)
            ),

          ],
        ),
      ),
      backgroundColor: ColorsManager.GREY,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight - MediaQuery.of(context).viewPadding.top,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(AppPaddings.p20),
                child: SizedBox(
                  height: screenWidth/ 1.3 - MediaQuery.of(context).viewPadding.top ,
                  child: Image.asset(AssetsManager.loginImage, fit: BoxFit.contain,)
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(AppPaddings.p10),
                  height: screenHeight / 1.8,
                  decoration: BoxDecoration(
                    color: ColorsManager.WHITE,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                  ),
                  child: Column(
                    children: [
                      Text("User Login",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18.sp)),
                      SizedBox(height: AppSizesDouble.s15,),
                      DefaultTextInputField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        hint: 'nigga', //TODO: add proper hint
                      ),
                      SizedBox(height:30.h),
                      DefaultTextInputField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hint: 'nigga', //TODO: add proper hint
                        onSuffixPressed: (){
                          setState(()  => isEyeVisible = !isEyeVisible);
                        },
                        suffixActivated: isEyeVisible,
                        suffixIconActivated: IconsManager.eyeOffIcon,
                        suffixIconInActivated: IconsManager.eyeIcon,
                      )
                    ],
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