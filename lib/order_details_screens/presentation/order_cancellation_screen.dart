import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/strings_manager.dart';

class OrderCancellationScreen extends StatefulWidget {
  const OrderCancellationScreen({super.key, required this.item});
  final DeliveryItem item;

  @override
  State<OrderCancellationScreen> createState() => _OrderCancellationScreenState();
}

class _OrderCancellationScreenState extends State<OrderCancellationScreen> {

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  int? cancellationValue;
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: MainCubit.get(context),
      listener: (context, state) {
        if(state is MainCancelOrderSuccessState){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.translate(StringsManager.orderCancellation), style: Theme.of(context).textTheme.headlineSmall,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppPaddings.p15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('${AppLocalizations.translate(StringsManager.yourOrderCode)} #${widget.item.orderNumber}', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.DARK_GREY),),
                SizedBox(height: AppSizesDouble.s30,),
                // FormField(
                //   initialValue: cancellationValue,
                //   validator: (value){
                //     if(value == null){
                //       return AppLocalizations.translate(StringsManager.requiredField);
                //     }
                //     return null;
                //   },
                //   builder: (state) => InputDecorator(
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       errorText: state.errorText,
                //       contentPadding: EdgeInsets.zero
                //     ),
                //     child: DefaultDropDownMenu(
                //       value: cancellationValue,
                //       hint: StringsManager.reason,
                //       items: AppConstants.numberItems, //TODO: adjust it to hold the reason list
                //       onChanged: (value){
                //         setState(() {
                //           cancellationValue = value;
                //         });
                //       }
                //     ),
                //   ),
                // ),
                DefaultTextInputField(
                  controller: _reasonController,
                  hint: StringsManager.description,
                  isRequired: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizesDouble.s30,),
                DefaultTextInputField(
                  controller: _descriptionController,
                  maxLines: AppSizes.s7,
                  hint: StringsManager.description,
                  isRequired: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizesDouble.s30,),
                DefaultButton(
                  title: StringsManager.confirmCancellation,
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      MainCubit.get(context).cancelOrder(widget.item.id!);
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
