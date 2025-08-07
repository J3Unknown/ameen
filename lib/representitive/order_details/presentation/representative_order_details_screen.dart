import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

import '../../../utill/local/localization/app_localization.dart';

class RepresentativeOrderDetailsScreen extends StatefulWidget {
  const RepresentativeOrderDetailsScreen({super.key});

  @override
  State<RepresentativeOrderDetailsScreen> createState() => _RepresentativeOrderDetailsScreenState();
}

class _RepresentativeOrderDetailsScreenState extends State<RepresentativeOrderDetailsScreen> {
  bool isDelivered = false;
  bool isOutForDelivery = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.translate(StringsManager.order)} #342342', style: Theme.of(context).textTheme.headlineSmall,),
        actions: [
          DefaultRoundedIconButton(onPressed: (){showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.cancel,));}, icon: IconsManager.close, iconColor: ColorsManager.WHITE, filled: true, backgroundColor: ColorsManager.RED ,borderColor: ColorsManager.RED,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.translate(StringsManager.clientDetails), style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppSizesDouble.s10,),
              IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10, vertical: AppPaddings.p15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorsManager.GREY1,
                      borderRadius: BorderRadius.circular(AppSizesDouble.s15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('This is a big very big title', style: Theme.of(context).textTheme.labelLarge,),
                      Text('${AppLocalizations.translate(StringsManager.name)}: a lil nigga', style: Theme.of(context).textTheme.labelLarge,),
                      Text('${AppLocalizations.translate(StringsManager.orderFee)}: 12 KWD', style: Theme.of(context).textTheme.labelLarge,),
                      Text('${AppLocalizations.translate(StringsManager.governance)}: Gov', style: Theme.of(context).textTheme.labelLarge,),
                      SizedBox(height: AppSizesDouble.s10,),
                      DefaultButton(
                        onPressed: (){},
                        title: StringsManager.call,
                        borderRadius: AppSizesDouble.s5,
                        backgroundColor: ColorsManager.COLUMBIA_BLUE,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s30,),
              Text(AppLocalizations.translate(StringsManager.originAddress), style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppSizesDouble.s10,),
              IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10, vertical: AppPaddings.p15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsManager.GREY1,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('This is a way so long address that it could reach the end of the container and it must even go down a bit more', style: Theme.of(context).textTheme.labelLarge,),
                      SizedBox(height: AppSizesDouble.s10,),
                      DefaultButton(
                        onPressed: (){},
                        title: StringsManager.origin,
                        borderRadius: AppSizesDouble.s5,
                        backgroundColor: ColorsManager.SOFT_GREEN,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s30,),
              Text(AppLocalizations.translate(StringsManager.destinationAddress), style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppSizesDouble.s10,),
              IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10, vertical: AppPaddings.p15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorsManager.GREY1,
                      borderRadius: BorderRadius.circular(AppSizesDouble.s15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('This is a way so long address that it could reach the end of the container and it must even go down a bit more', style: Theme.of(context).textTheme.labelLarge,),
                      SizedBox(height: AppSizesDouble.s10,),
                      DefaultButton(
                        onPressed: (){},
                        title: StringsManager.destination,
                        borderRadius: AppSizesDouble.s5,
                        backgroundColor: ColorsManager.SOFT_RED,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s30,),
              ListTile(
                leading: Checkbox(
                  value: isOutForDelivery,
                  activeColor: ColorsManager.PRIMARY_COLOR,
                  side: BorderSide(color: ColorsManager.PRIMARY_COLOR, width: 2),
                  onChanged: (value){
                    showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.outForDelivery));
                  }
                ),
                title: Text(AppLocalizations.translate(StringsManager.outForDelivery), style: Theme.of(context).textTheme.labelLarge,),
              ),
              ListTile(
                leading: Checkbox(
                  value: isDelivered,
                  activeColor: ColorsManager.PRIMARY_COLOR,
                  side: BorderSide(color: ColorsManager.PRIMARY_COLOR, width: AppSizesDouble.s2),
                  onChanged: (value){
                    showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.orderDelivered));
                  }
                ),
                title: Text(AppLocalizations.translate(StringsManager.orderDelivered), style: Theme.of(context).textTheme.labelLarge,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
