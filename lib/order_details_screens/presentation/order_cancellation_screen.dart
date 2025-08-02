import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/strings_manager.dart';

class OrderCancellationScreen extends StatefulWidget {
  const OrderCancellationScreen({super.key});

  @override
  State<OrderCancellationScreen> createState() => _OrderCancellationScreenState();
}

class _OrderCancellationScreenState extends State<OrderCancellationScreen> {

  final TextEditingController _descriptionController = TextEditingController();
  String? cancellationValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.orderCancellation), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: Column(
          children: [
            Text('${AppLocalizations.translate(StringsManager.yourOrderCode)} #23423423', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.DARK_GREY),),
            SizedBox(height: AppSizesDouble.s30,),
            DefaultDropDownMenu(
              value: cancellationValue,
              hint: StringsManager.reason,
              items: AppConstants.items,
              onChanged: (value){
                setState(() {
                  cancellationValue = value;
                });
              }
            ),
            SizedBox(height: AppSizesDouble.s30,),
            DefaultTextInputField(
              controller: _descriptionController,
              maxLines: 7,
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
              onPressed: (){}
            )
          ],
        ),
      ),
    );
  }
}
