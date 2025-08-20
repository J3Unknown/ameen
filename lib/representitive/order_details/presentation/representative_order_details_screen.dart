import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit_states.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../utill/local/localization/app_localization.dart';

class RepresentativeOrderDetailsScreen extends StatefulWidget {
  const RepresentativeOrderDetailsScreen({super.key, required this.item});
  final DeliveryItem item;
  @override
  State<RepresentativeOrderDetailsScreen> createState() => _RepresentativeOrderDetailsScreenState();
}

class _RepresentativeOrderDetailsScreenState extends State<RepresentativeOrderDetailsScreen> {
  bool isDelivered = false;
  bool isOutForDelivery = false;

  @override
  void initState() {
    isOutForDelivery = widget.item.status == 'out_for_delivery';
    isDelivered = widget.item.status == 'delivered';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentativeCubit, RepresentativeCubitStates>(
      listener: (context, state) {
        if(state is RepresentativeCancelOrderSuccessState){
          RepresentativeCubit.get(context).cancelledOrdersDataModel!.items.add(widget.item);
          RepresentativeCubit.get(context).newOrdersDataModel!.items.removeWhere((e) => e.id == widget.item.id);
          Navigator.pop(context);
        }
        if(state is RepresentativeChangeOutForDeliveryStatusSuccessState){
          setState(() {
            isOutForDelivery = !isOutForDelivery;
          });
        }
        if(state is RepresentativeChangeDeliveredStatusSuccessState){
          setState(() {
            isDelivered = !isDelivered;
          });
          RepresentativeCubit.get(context).deliveredOrdersDataModel!.items.add(widget.item);
          RepresentativeCubit.get(context).newOrdersDataModel!.items.removeWhere((e) => e.id == widget.item.id);
          Navigator.pop(context);
        }
        if(state is RepresentativeChangeDeliveredStatusErrorState){
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('${AppLocalizations.translate(StringsManager.order)} #${widget.item.orderNumber}', style: Theme.of(context).textTheme.headlineSmall,),
          actions: [
            DefaultRoundedIconButton(onPressed: (){
              showDialog(
                context: context,
                builder: (context) => DefaultRepresentativeChangeState(
                  state: StringsManager.cancel,
                  action: () => RepresentativeCubit.get(context).cancelItem(widget.item.id!),
                )
              );
            }, icon: IconsManager.close, iconColor: ColorsManager.WHITE, filled: true, backgroundColor: ColorsManager.RED ,borderColor: ColorsManager.RED,)
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
                        Text(widget.item.title??'', style: Theme.of(context).textTheme.labelLarge,),
                        Text('${AppLocalizations.translate(StringsManager.name)}: ${widget.item.user!.name}', style: Theme.of(context).textTheme.labelLarge,),
                        Text('${AppLocalizations.translate(StringsManager.orderFee)}: ${widget.item.fee} ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.labelLarge,),
                        SizedBox(height: AppSizesDouble.s10,),
                        DefaultButton(
                          onPressed: () async => await FlutterPhoneDirectCaller.callNumber(widget.item.user!.phone),
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
                          onPressed: () {},
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
                      showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.outForDelivery, action: () => RepresentativeCubit.get(context).changeOutForDeliveryStatus(widget.item.id!),));
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
                      showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.orderDelivered, action: () => RepresentativeCubit.get(context).changeDeliveredStatus(widget.item.id!),));
                    }
                  ),
                  title: Text(AppLocalizations.translate(StringsManager.orderDelivered), style: Theme.of(context).textTheme.labelLarge,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
