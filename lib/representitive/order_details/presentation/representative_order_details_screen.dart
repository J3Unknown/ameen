import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
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
        title: Text('Order #342342', style: Theme.of(context).textTheme.headlineSmall,),
        actions: [
          DefaultRoundedIconButton(onPressed: (){showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: 'Cancel',));}, icon: IconsManager.close, iconColor: ColorsManager.WHITE, filled: true, backgroundColor: ColorsManager.RED ,borderColor: ColorsManager.RED,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Client Details', style: Theme.of(context).textTheme.headlineSmall,),
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
                      Text('Name: a lil nigga', style: Theme.of(context).textTheme.labelLarge,),
                      Text('Order Fee: 12 KWD', style: Theme.of(context).textTheme.labelLarge,),
                      Text('Governance: Gov', style: Theme.of(context).textTheme.labelLarge,),
                      SizedBox(height: AppSizesDouble.s10,),
                      DefaultButton(
                        onPressed: (){},
                        title: AppLocalizations.translate('Call'),
                        borderRadius: AppSizesDouble.s5,
                        backgroundColor: ColorsManager.COLUMBIA_BLUE,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s30,),
              Text('Origin Address', style: Theme.of(context).textTheme.headlineSmall,),
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
                        title: AppLocalizations.translate('Origin'),
                        borderRadius: AppSizesDouble.s5,
                        backgroundColor: ColorsManager.SOFT_GREEN,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s30,),
              Text('Destination Address', style: Theme.of(context).textTheme.headlineSmall,),
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
                        title: AppLocalizations.translate('Destination'),
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
                    // setState(() {
                    //   isOutForDelivery = value!;
                    // });
                      showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: 'out for delivery'));
                  }
                ),
                title: Text('Out For Delivery', style: Theme.of(context).textTheme.labelLarge,),
              ),
              ListTile(
                leading: Checkbox(
                  value: isDelivered,
                  activeColor: ColorsManager.PRIMARY_COLOR,
                  side: BorderSide(color: ColorsManager.PRIMARY_COLOR, width: 2),
                  onChanged: (value){
                    // setState(() {
                    //   isDelivered = value!;
                    // });
                      showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: 'Order Delivered'));
                  }
                ),
                title: Text('Order Deliverd', style: Theme.of(context).textTheme.labelLarge,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
