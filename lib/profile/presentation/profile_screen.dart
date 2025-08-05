import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/strings_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
            maxLength: 8,
            isRequired: true,
            validator: (value){
              if(value == null || value.isEmpty){
                return AppLocalizations.translate(StringsManager.emptyFieldMessage);
              } else if(value.length < 8){
                return AppLocalizations.translate(StringsManager.phoneNumberRangeError);
              }
              return null;
            },
          ),
          SizedBox(height: AppSizesDouble.s10,),
          DefaultTextInputField(
            controller: _emailController,
            title: StringsManager.email,
            isRequired: true,
            validator: (value){
              if(value == null || value.isEmpty){
                return AppLocalizations.translate(StringsManager.emptyFieldMessage);
              }
              return null;
            },
          ),
          SizedBox(height: AppSizesDouble.s20,),
          DefaultButton(
            title: StringsManager.update,
            onPressed: (){}
          ),
          SizedBox(height: AppSizesDouble.s20,),
          DefaultButton(
            title: StringsManager.deleteAccount,
            hasBorder: false,
            backgroundColor: ColorsManager.RED,
            onPressed: (){}
          )
        ],
      )
    ),
    );
  }
}
