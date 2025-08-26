import 'dart:developer';

import 'package:ameen/google_map_services/data/map_screen_arguments.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit_states.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  DeliveryItem? item;

  Position? _position;
  bool locationServiceEnabled = false;
  bool permissionGranted = false;


  @override
  void initState() {
    super.initState();
    isOutForDelivery = widget.item.status == 'out_for_delivery';
    isDelivered = widget.item.status == 'delivered';
    context.read<RepresentativeCubit>().getOrderDetails(int.parse(widget.item.id!));
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(context, 'Please enable the location service');
      return;
    } else {
      setState(() {
        locationServiceEnabled = true;
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(context, 'Please give the permission');
        return;
      }
      else{
        setState(() {
          permissionGranted = true;
        });
      }
    } else {
      setState(() {
        permissionGranted = true;
      });
    }

    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context, 'Please give the permission, to be able to use maps');
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _position = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentativeCubit, RepresentativeCubitStates>(
      listener: (context, state) {
        if(state is RepresentativeGetOrderDetailsSuccessState){
          item = state.item;
        }
        if(state is RepresentativeCancelOrderSuccessState){
          RepresentativeCubit.get(context).cancelledOrdersDataModel!.items.add(item!);
          RepresentativeCubit.get(context).newOrdersDataModel!.items.removeWhere((e) => e.id == item!.id);
          Navigator.pop(context);
        }
        if(state is RepresentativeChangeOutForDeliveryStatusSuccessState){
          setState(() {
            isOutForDelivery = true;
          });
        }
        if(state is RepresentativeChangeDeliveredStatusSuccessState){
          RepresentativeCubit.get(context).deliveredOrdersDataModel!.items.add(item!);
          RepresentativeCubit.get(context).newOrdersDataModel!.items.removeWhere((e) => e.id == item!.id);
          setState(() {
            isDelivered = true;
          });
          Navigator.pop(context);
        }
        if(state is RepresentativeChangeDeliveredStatusErrorState){
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) =>Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          surfaceTintColor: ColorsManager.TRANSPARENT,
          title: Text('${AppLocalizations.translate(StringsManager.order)} #${item != null? item!.orderNumber:''}', style: Theme.of(context).textTheme.headlineSmall,),
          actions: [
            if(item != null)
            DefaultRoundedIconButton(onPressed: (){
              showDialog(
                context: context,
                builder: (context) => DefaultRepresentativeChangeState(
                  state: StringsManager.cancel,
                  action: () => RepresentativeCubit.get(context).cancelItem(item!.id!),
                )
              );
            }, icon: IconsManager.close, iconColor: ColorsManager.WHITE, filled: true, backgroundColor: ColorsManager.RED ,borderColor: ColorsManager.RED,)
          ],
        ),
        body: ConditionalBuilder(
          condition: item != null,
          fallback: (context) => Center(child: CircularProgressIndicator(),),
          builder: (context) => Padding(
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
                          Text(item!.title??'', style: Theme.of(context).textTheme.labelLarge,),
                          Text('${AppLocalizations.translate(StringsManager.name)}: ${item!.user!.name}', style: Theme.of(context).textTheme.labelLarge,),
                          Text('${AppLocalizations.translate(StringsManager.orderFee)}: ${item!.fee} ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.labelLarge,),
                          SizedBox(height: AppSizesDouble.s10,),
                          DefaultButton(
                            onPressed: () async => await FlutterPhoneDirectCaller.callNumber(item!.user!.phone),
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
                          Text('${item!.originAddress!.blockNo} ${item!.originAddress!.street} ${item!.originAddress!.buildingNo} ${item!.originAddress!.floorNo}', style: Theme.of(context).textTheme.labelLarge,),
                          SizedBox(height: AppSizesDouble.s10,),
                          DefaultButton(
                            onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.deliveryDestinationTracking, arguments: MapScreenArguments(item!, isOrigin: true)))),
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
                          Text('${item!.destinationAddress!.blockNo} ${item!.destinationAddress!.street} ${item!.destinationAddress!.buildingNo} ${item!.destinationAddress!.floorNo}', style: Theme.of(context).textTheme.labelLarge,),
                          SizedBox(height: AppSizesDouble.s10,),
                          DefaultButton(
                            onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.deliveryDestinationTracking, arguments: MapScreenArguments(item!)))),
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
                    leading: IgnorePointer(
                      ignoring: isOutForDelivery,
                      child: Checkbox(
                        value: isOutForDelivery,
                        activeColor: ColorsManager.PRIMARY_COLOR,
                        side: BorderSide(color: ColorsManager.PRIMARY_COLOR, width: 2),
                        onChanged:(value){
                          if(!permissionGranted || !locationServiceEnabled){
                            showSnackBar(context, 'Enable Location Service And Give Location Permissions to proceed');
                          }
                          showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.outForDelivery, action: () => RepresentativeCubit.get(context).changeOutForDeliveryStatus(item!.id!, LatLng(_position!.latitude, _position!.longitude)),));
                        }
                      ),
                    ),
                    title: Text(AppLocalizations.translate(StringsManager.outForDelivery), style: Theme.of(context).textTheme.labelLarge,),
                  ),
                  ListTile(
                    leading: IgnorePointer(
                      ignoring: !isOutForDelivery,
                      child: Checkbox(
                        value: isDelivered,
                        activeColor: ColorsManager.PRIMARY_COLOR,
                        side: BorderSide(color: ColorsManager.PRIMARY_COLOR, width: AppSizesDouble.s2),
                        onChanged: (value){
                          showDialog(context: context, builder: (context) => DefaultRepresentativeChangeState(state: StringsManager.orderDelivered, action: () => RepresentativeCubit.get(context).changeDeliveredStatus(item!.id!),));
                        }
                      ),
                    ),
                    title: Text(AppLocalizations.translate(StringsManager.orderDelivered), style: Theme.of(context).textTheme.labelLarge,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
