import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/strings_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _nameController = TextEditingController(text: Repo.profileDataModel!.name);
    _phoneController = TextEditingController(text: Repo.profileDataModel!.phone);
    _emailController = TextEditingController(text: Repo.profileDataModel!.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.profile), style: Theme.of(context).textTheme.headlineSmall,),
      ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(AppPaddings.p20),
      child: Column(
        children: [
          SizedBox(
            height: AppSizesDouble.s120,
            width: double.infinity,
            child: InkWell(
              onTap: (){},
              child: SvgPicture.asset(AssetsManager.addImageIcon, fit: BoxFit.contain, colorFilter: ColorFilter.mode(ColorsManager.DEEP_BLUE, BlendMode.srcIn),)
            ),
          ),
          SizedBox(height: AppSizesDouble.s50,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DefaultTextInputField(
                  controller: _nameController,
                  title: StringsManager.name,
                  isRequired: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizesDouble.s20,),
                DefaultTextInputField(
                  controller: _phoneController,
                  title: StringsManager.whatsappNumber,
                  keyboardType: TextInputType.phone,
                  maxLength: AppSizes.s8,
                  isRequired: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                    } else if(value.length < AppSizes.s8){
                      return AppLocalizations.translate(StringsManager.phoneNumberRangeError);
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizesDouble.s10,),
          DefaultTextInputField(
            controller: _emailController,
            title: StringsManager.email,
            validator: (value){
              if(value == null || value.isEmpty){
                return AppLocalizations.translate(StringsManager.emptyFieldMessage);
              } else if(!value.contains(AppConstants.emailRegex)){
                return '${AppLocalizations.translate(StringsManager.emailFormatWarning)}: ${StringsManager.emailPlaceholder}';
              }
              return null;
            },
          ),
          SizedBox(height: AppSizesDouble.s10,),
          DefaultTextInputField(
            controller: _passwordController,
            title: StringsManager.password,
            hint: StringsManager.passwordHint,
            isRequired: false,
            suffixActivated: true,
            keyboardType: TextInputType.visiblePassword,
            suffixIconActivated: IconsManager.eyeIcon,
            suffixIconInActivated: IconsManager.eyeOffIcon,
            validator: (value){
              if(value == null || value.isEmpty){
                return AppLocalizations.translate(StringsManager.emptyFieldMessage);
              }  else if(value.length < AppSizes.s8){
                return AppLocalizations.translate(StringsManager.passwordLengthMessage);
              }
              return null;
            },
          ),
          SizedBox(height: AppSizesDouble.s20,),
          DefaultButton(
            title: StringsManager.update,
            onPressed: (){
              if(_formKey.currentState!.validate()){
                MainCubit.get(context).updateAccount(
                  context,
                  _nameController.text,
                  _phoneController.text,
                  email: _emailController.text,
                  password: _passwordController.text
                );
              }
            }
          ),
          SizedBox(height: AppSizesDouble.s20,),
          DefaultButton(
            title: StringsManager.deleteAccount,
            hasBorder: false,
            backgroundColor: ColorsManager.RED,
            onPressed: () => showDialog(context: context, builder: (context) => DefaultDeleteAccountAlert())
          )
        ],
      )
    ),
    );
  }
}
