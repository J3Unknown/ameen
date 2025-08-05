import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/strings_manager.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.translate(StringsManager.support), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p25, vertical: AppPaddings.p40),
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
              controller: _messageController,
              title: StringsManager.message,
              isRequired: true,
              maxLines: 7,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s20,),
            DefaultButton(
              title: StringsManager.send,
              onPressed: (){}
            ),
            SizedBox(height: AppSizesDouble.s20,),
            Row(
              children: [
                Expanded(child: DefaultRoundedIconButton(onPressed: (){}, hasBorder: false, isSvg: true, svgIcon: AssetsManager.whatsapp,)),
                Expanded(child: DefaultRoundedIconButton(onPressed: (){}, hasBorder: false, isSvg: true, svgIcon: AssetsManager.facebook,)),
                Expanded(child: DefaultRoundedIconButton(onPressed: (){}, hasBorder: false, isSvg: true, svgIcon: AssetsManager.instagram,)),
                Expanded(child: DefaultRoundedIconButton(onPressed: (){}, hasBorder: false, isSvg: true, svgIcon: AssetsManager.call,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
