import 'package:ameen/Repo/repo.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../home_layout/cubit/main_cubit.dart';
import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/strings_manager.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if(Repo.aboutUsAndSupportDataModel == null){
      context.read<MainCubit>().getAboutUs();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _messageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.translate(StringsManager.support), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p25, vertical: AppPaddings.p40),
        child: Form(
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
                onPressed: (){
                  //TODO: set the support endPoint
                }
              ),
              SizedBox(height: AppSizesDouble.s20,),
              Row(
                children: [
                  Expanded(child: DefaultRoundedIconButton(onPressed: () => launchUrl(Repo.aboutUsAndSupportDataModel!.whatsappNumber), hasBorder: false, isSvg: true, svgIcon: AssetsManager.whatsapp,)),
                  Expanded(child: DefaultRoundedIconButton(onPressed: () => launchUrl(Repo.aboutUsAndSupportDataModel!.facebook), hasBorder: false, isSvg: true, svgIcon: AssetsManager.facebook,)),
                  Expanded(child: DefaultRoundedIconButton(onPressed: () => launchUrl(Repo.aboutUsAndSupportDataModel!.instagram), hasBorder: false, isSvg: true, svgIcon: AssetsManager.instagram,)),
                  Expanded(child: DefaultRoundedIconButton(onPressed: () async => await FlutterPhoneDirectCaller.callNumber(Repo.aboutUsAndSupportDataModel!.whatsappNumber), hasBorder: false, isSvg: true, svgIcon: AssetsManager.call,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
