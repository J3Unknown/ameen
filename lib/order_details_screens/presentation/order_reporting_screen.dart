import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/colors_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class OrderReportingScreen extends StatefulWidget {
  const OrderReportingScreen({super.key, required this.item});
  final DeliveryItem item;
  @override
  State<OrderReportingScreen> createState() => _OrderReportingScreenState();
}

class _OrderReportingScreenState extends State<OrderReportingScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  int? overallExperienceValue;
  int? deliveryTimeValue;
  int? deliveryAgentValue;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: MainCubit.get(context),
      listener: (context, state) {
        if(state is MainSendReportingSuccessState){
          showSnackBar(context, 'Rating was sent');
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.translate(StringsManager.orderReporting), style: Theme.of(context).textTheme.headlineSmall,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppPaddings.p15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('${AppLocalizations.translate(StringsManager.yourOrderCode)} #${widget.item.orderNumber}', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.DARK_GREY),),
                SizedBox(height: AppSizesDouble.s30,),
                FormField(
                  initialValue: overallExperienceValue,
                  validator: (value){
                    if(value == null){
                      return AppLocalizations.translate(StringsManager.requiredField);
                    }
                    return null;
                  },
                  builder: (state) => InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      errorText: state.errorText
                    ),
                    child: DefaultDropDownMenu(
                      value: overallExperienceValue,
                      title: StringsManager.overallRate,
                      hint: StringsManager.oneToTen,
                      items: AppConstants.numberItems,
                      onChanged: (value){
                        setState(() {
                          overallExperienceValue = value;
                        });
                      }
                    ),
                  ),
                ),
                SizedBox(height: AppSizesDouble.s30,),
                FormField(
                  initialValue: deliveryTimeValue,
                  validator: (value){
                    if(value == null){
                      return AppLocalizations.translate(StringsManager.requiredField);
                    }
                    return null;
                  },
                  builder: (state) => InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      errorText: state.errorText
                    ),
                    child: DefaultDropDownMenu(
                      value: deliveryTimeValue,
                      title: StringsManager.deliveryTimeRate,
                      hint: StringsManager.oneToTen,
                      items: AppConstants.numberItems,
                      onChanged: (value){
                        setState(() {
                          deliveryTimeValue = value;
                        });
                      }
                    ),
                  ),
                ),
                SizedBox(height: AppSizesDouble.s30,),
                FormField(
                  initialValue: deliveryAgentValue,
                  validator: (value){
                    if(value == null){
                      return AppLocalizations.translate(StringsManager.requiredField);
                    }
                    return null;
                  },
                  builder: (state) => InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      errorText: state.errorText
                    ),
                    child: DefaultDropDownMenu(
                      value: deliveryAgentValue,
                      title: StringsManager.deliveryAgentRate,
                      hint: StringsManager.oneToTen,
                      items: AppConstants.numberItems,
                      onChanged: (value){
                        setState(() {
                          deliveryAgentValue = value;
                        });
                      }
                    ),
                  ),
                ),
                SizedBox(height: AppSizesDouble.s30,),
                DefaultTextInputField(
                  controller: _descriptionController,
                  maxLines: 5,
                  title: StringsManager.describeYourExperience,
                  isRequired: true,
                  hint: StringsManager.description,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizesDouble.s30,),
                DefaultButton(
                  title: StringsManager.sendRating,
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      MainCubit.get(context).sendReporting(
                        widget.item.id!,
                        overallExperienceValue!,
                        deliveryTimeValue!,
                        deliveryAgentValue!,
                        _descriptionController.text
                      );
                    }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
