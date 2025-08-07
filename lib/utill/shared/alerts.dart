import 'package:ameen/sahl/presentation/verification_screen/sahl_verification_screen.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAddressAlert extends StatefulWidget {
  const AddAddressAlert({super.key, required this.title});
  final String title;
  @override
  State<AddAddressAlert> createState() => _AddAddressAlertState();
}

class _AddAddressAlertState extends State<AddAddressAlert> {
  String? selectedGovernance;
  String? selectedCity;
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: AppPaddings.p15, vertical: AppPaddings.p25),
      actions: [
        DefaultButton(
          title: StringsManager.addAddress,
          onPressed: (){
            if(_formKey.currentState!.validate()){

            }
          }
        )
      ],
      backgroundColor: ColorsManager.WHITE,
      title: Text(AppLocalizations.translate(widget.title)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultDropDownMenu(
              value: selectedGovernance,
              hint: StringsManager.governance,
              items: AppConstants.items,
              onChanged: (value){
                if(value != null){
                  setState(() {
                    selectedGovernance = value;
                  });
                }
              }
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultDropDownMenu(
              value: selectedCity,
              hint: StringsManager.city,
              items: AppConstants.items,
              onChanged: (value){
                if(value != null){
                  setState(() {
                    selectedCity = value;
                  });
                }
              }
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultTextInputField(
              controller: _blockController,
              hint: StringsManager.block,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultTextInputField(
              controller: _streetController,
              hint: StringsManager.street,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultTextInputField(
              controller: _buildingController,
              hint: StringsManager.building,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultTextInputField(
              controller: _floorController,
              hint: StringsManager.floor,
              keyboardType: TextInputType.number,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultTextInputField(
              controller: _landMarkController,
              hint: StringsManager.landmark,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginAlert extends StatelessWidget {
  const LoginAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.translate(StringsManager.login), style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
      content: Text(AppLocalizations.translate(StringsManager.loginAlert), style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
      backgroundColor: ColorsManager.WHITE,
      actions: [
        DefaultButton(title: StringsManager.login, onPressed: (){}), //TODO: Link with login action
        SizedBox(height: AppSizesDouble.s20,),
        DefaultButton(
          title: StringsManager.cancel,
          backgroundColor: ColorsManager.WHITE,
          hasBorder: true,
          borderColor: ColorsManager.WHITE,
          foregroundColor: ColorsManager.DARK_GREY,
          onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}


class LanguageAlert extends StatefulWidget {
  const LanguageAlert({super.key});

  @override
  State<LanguageAlert> createState() => _LanguageAlertState();
}

class _LanguageAlertState extends State<LanguageAlert> {
  String selectedLang = AppConstants.locale;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.translate(StringsManager.language), style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
      backgroundColor: ColorsManager.WHITE,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultRadioTile(
            title: StringsManager.arabic,
            value: 'SA',
            groupValue: selectedLang,
            onChanged: (value){
              setState(() {
                selectedLang = value;
              });
            }
          ),
          SizedBox(height: AppSizesDouble.s10,),
          DefaultRadioTile(
            title: StringsManager.english,
            value: 'EN',
            groupValue: selectedLang,
            onChanged: (value){
              setState(() {
                selectedLang = value;
              });
            }
          )
        ],
      ),
      actions: [
        DefaultButton(title: StringsManager.apply, onPressed: (){}), //TODO: Link with apply action
        SizedBox(height: AppSizesDouble.s20,),
        DefaultButton(
          title: StringsManager.cancel,
          backgroundColor: ColorsManager.WHITE,
          hasBorder: false,
          foregroundColor: ColorsManager.DARK_GREY,
          onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}

class DefaultRepresentativeChangeState extends StatelessWidget {
  const DefaultRepresentativeChangeState({super.key, required this.state});
  final String state;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: SvgPicture.asset(AssetsManager.alertIcon),
      content: Text('${AppLocalizations.translate(StringsManager.changingOrderStateMessage)} "${AppLocalizations.translate(state).toUpperCase()}"', style: Theme.of(context).textTheme.displaySmall,),
      actions: [
        DefaultButton(
          title: StringsManager.yes,
          onPressed: (){},
          backgroundColor: ColorsManager.RED,
        ), //TODO: Link with apply action
        SizedBox(height: AppSizesDouble.s20,),
        DefaultButton(
          title: StringsManager.cancel,
          backgroundColor: ColorsManager.WHITE,
          hasBorder: true,
          borderColor: ColorsManager.PRIMARY_COLOR,
          foregroundColor: ColorsManager.PRIMARY_COLOR,
          onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}

class SahlVerificationAlert extends StatelessWidget {
  const SahlVerificationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          DefaultRoundedIconButton(onPressed: null, icon: IconsManager.check,),
          Text(AppLocalizations.translate(StringsManager.sahlVerificationCheckMessage), style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
        ],
      ),
      backgroundColor: ColorsManager.WHITE,
      actions: [
        DefaultButton(title: StringsManager.login, onPressed: (){}), //TODO: Link with login action
        SizedBox(height: AppSizesDouble.s20,),
        DefaultButton(
            title: StringsManager.cancel,
            backgroundColor: ColorsManager.WHITE,
            hasBorder: true,
            borderColor: ColorsManager.WHITE,
            foregroundColor: ColorsManager.DARK_GREY,
            onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}