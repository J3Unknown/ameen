import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/item_delivery_screen/data/add_address_requests_model/address_base_model.dart';
import 'package:ameen/item_delivery_screen/data/address_data_model.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/local/localization/locale_changer.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddAddressAlert extends StatefulWidget {
  const AddAddressAlert({super.key, required this.title, required this.requestModel, this.editingAddress});
  final String title;
  final AddressBaseModel requestModel;
  final Address? editingAddress;
  @override
  State<AddAddressAlert> createState() => _AddAddressAlertState();
}

class _AddAddressAlertState extends State<AddAddressAlert> {
  int? selectedGovernance;
  int? selectedCity;
  late final TextEditingController _blockController;
  late final TextEditingController _streetController;
  late final TextEditingController _buildingController;
  late final TextEditingController _floorController;
  late final TextEditingController _landMarkController;
  late final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _blockController = TextEditingController(text: widget.editingAddress?.blockNo);
    _floorController = TextEditingController(text: widget.editingAddress?.floorNo);
    _streetController = TextEditingController(text: widget.editingAddress?.street);
    _buildingController = TextEditingController(text: widget.editingAddress?.buildingNo);
    _landMarkController = TextEditingController(text: widget.editingAddress?.landmark);
    selectedGovernance = widget.editingAddress?.city!.id;
    selectedCity = widget.editingAddress?.region!.id;
    if(context.read<MainCubit>().cities == null){
      context.read<MainCubit>().getCities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(
      listener: (context, state) {
        if(state is MainCreateAddressSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context, state) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: AppPaddings.p10, vertical: AppPaddings.p20),
        actions: [
          DefaultButton(
            title: StringsManager.addAddress,
            isLoading: state is MainCreateAddressLoadingState,
            onPressed: (){
              if(_formKey.currentState!.validate()){
                widget.requestModel.request(context, selectedCity!, selectedGovernance!, _blockController.text, _buildingController.text, _floorController.text, _landMarkController.text, _streetController.text);
              }
            }
          )
        ],
        backgroundColor: ColorsManager.WHITE,
        title: Text(AppLocalizations.translate(widget.title)),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(MainCubit.get(context).cities != null)
                FormField(
                  initialValue: selectedGovernance,
                  validator: (value){
                    if(value == null){
                      return AppLocalizations.translate(StringsManager.requiredField);
                    }
                    return null;
                  },
                  builder: (state) => InputDecorator(
                    decoration: InputDecoration(
                      errorText: state.errorText,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    child: DefaultDropDownMenu(
                      value: selectedGovernance,
                      hint: StringsManager.governance,
                      items: MainCubit.get(context).cities!.objects,
                      onChanged: (value){
                        if(value != null){
                          setState(() {
                            selectedGovernance = value;
                            selectedCity = null;
                          });
                          MainCubit.get(context).getRegions(selectedGovernance!);
                        }
                      },
                    ),
                  )
                ),
                if(MainCubit.get(context).regions != null && selectedGovernance != null)
                SizedBox(height: AppSizesDouble.s10,),
                if(MainCubit.get(context).regions != null && selectedGovernance != null)
                FormField(
                  initialValue: selectedCity,
                  validator: (value){
                    if(value == null){
                      return AppLocalizations.translate(StringsManager.requiredField);
                    }
                    return null;
                  },
                  builder: (state) => InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      errorText: state.errorText,
                      border: InputBorder.none,
                    ),
                    child: DefaultDropDownMenu(
                      value: selectedCity,
                      hint: StringsManager.city,
                      items: MainCubit.get(context).regions!.objects,
                      onChanged: (value){
                        if(value != null){
                          setState(() {
                            selectedCity = value;
                          });
                        }
                      }
                    ),
                  ),
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
  late LocaleChanger localeModel;
  late String selectedLang;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localeModel = Provider.of<LocaleChanger>(context);
    selectedLang = localeModel.getLanguage;
  }

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
            value: 'ar',
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
            value: 'en',
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
        DefaultButton(title: StringsManager.apply, onPressed: (){
          localeModel.changeLocale(selectedLang);
        }),
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
  const DefaultRepresentativeChangeState({super.key, required this.state, required this.action});
  final String state;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.WHITE,
      icon: SvgPicture.asset(AssetsManager.alertIcon),
      content: Text('${AppLocalizations.translate(StringsManager.changingOrderStateMessage)} "${AppLocalizations.translate(state).toUpperCase()}"', style: Theme.of(context).textTheme.displaySmall,),
      actions: [
        DefaultButton(
          title: StringsManager.yes,
          onPressed: (){
            action;
            showSnackBar(context, StringsManager.updatingStatus);
            Navigator.pop(context);
          },
          backgroundColor: ColorsManager.RED,
        ),
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

class DefaultDeleteAccountAlert extends StatelessWidget {
  const DefaultDeleteAccountAlert({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: MainCubit.get(context),
      listener: (context, state) {
        if(state is MainDeleteAccountSuccessState){
          clearCaches();
          Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.login)), (route) => false);
        }
      },
      child: AlertDialog(
        icon: SvgPicture.asset(AssetsManager.alertIcon),
        content: Text(AppLocalizations.translate('Are you Sure you want to DELETE your account!!'), style: Theme.of(context).textTheme.displaySmall,),
        actions: [
          DefaultButton(
            title: StringsManager.deleteAccount,
            onPressed: () => MainCubit.get(context).deleteAccount(),
            backgroundColor: ColorsManager.RED,
          ),
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
      ),
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