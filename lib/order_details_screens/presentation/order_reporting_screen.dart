import 'package:flutter/material.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/colors_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class OrderReportingScreen extends StatefulWidget {
  const OrderReportingScreen({super.key});

  @override
  State<OrderReportingScreen> createState() => _OrderReportingScreenState();
}

class _OrderReportingScreenState extends State<OrderReportingScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  String? overallExperienceValue;
  String? deliveryTimeValue;
  String? deliveryAgentValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.orderReporting), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: Column(
          children: [
            Text('${AppLocalizations.translate(StringsManager.yourOrderCode)} #23423423', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.DARK_GREY),),
            SizedBox(height: AppSizesDouble.s30,),
            DefaultDropDownMenu(
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
            SizedBox(height: AppSizesDouble.s30,),
            DefaultDropDownMenu(
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
            SizedBox(height: AppSizesDouble.s30,),
            DefaultDropDownMenu(
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
              onPressed: (){}
            )
          ],
        ),
      ),
    );
  }
}
