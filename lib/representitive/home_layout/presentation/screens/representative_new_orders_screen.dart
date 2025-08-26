import 'package:ameen/Repo/repo.dart';
import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/auth/cubit/auth_cubit_state.dart';
import 'package:ameen/google_map_services/data/map_screen_arguments.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit_states.dart';
import 'package:ameen/utill/local/shared_preferences.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../utill/local/localization/app_localization.dart';
import '../../../../utill/shared/assets_manager.dart';
import '../../../../utill/shared/strings_manager.dart';

class RepresentativeNewOrdersScreen extends StatefulWidget {
  const RepresentativeNewOrdersScreen({super.key});

  @override
  State<RepresentativeNewOrdersScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<RepresentativeNewOrdersScreen> {

  late RepresentativeCubit _cubit;
  int? navigationId;

  bool isOrigin = false;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<RepresentativeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentativeCubit, RepresentativeCubitStates>(
      listener: (context, state) {
        if(state is RepresentativeGetOrderDetailsSuccessState){
          if(navigationId == int.parse(state.item.id!)){
            navigationId = null;
            Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.deliveryDestinationTracking, arguments: MapScreenArguments(state.item, isOrigin: isOrigin))));
          }
        }
      },
      builder: (context, state) => ConditionalBuilder(
        fallback: (context) {
          if(_cubit.newOrdersDataModel != null && _cubit.newOrdersDataModel!.items.isEmpty){
            return Center(
              child: Text(AppLocalizations.translate(StringsManager.noOrdersYet)),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        condition: _cubit.newOrdersDataModel != null && _cubit.newOrdersDataModel!.items.isNotEmpty,
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) => IntrinsicHeight(
            child: InkWell(
              onTap: (){
                Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.representativeOrderDetails, arguments: _cubit.newOrdersDataModel!.items[index])));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10, vertical: AppPaddings.p15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.GREY1,
                  borderRadius: BorderRadius.circular(AppSizesDouble.s15)
                ),
                constraints: BoxConstraints(
                  maxHeight: AppSizesDouble.s200,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AssetsManager.itemIcon),
                        SizedBox(width: AppSizesDouble.s7,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_cubit.newOrdersDataModel!.items[index].title??'', style: Theme.of(context).textTheme.labelLarge, maxLines: AppSizes.s2, overflow: TextOverflow.ellipsis,),
                              SizedBox(height: AppSizesDouble.s10,),
                              Text('${AppLocalizations.translate(StringsManager.clientDetails)}: ${_cubit.newOrdersDataModel!.items[index].user!.name}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                              Text('${AppLocalizations.translate(StringsManager.deliveryDate)}: ${DateFormat('EEE dd, MMM, yyyy').format(_cubit.newOrdersDataModel!.items[index].deliveryTime != null?DateTime.parse(_cubit.newOrdersDataModel!.items[index].deliveryTime!):DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                              Text('${AppLocalizations.translate(StringsManager.orderFee)}: ${_cubit.newOrdersDataModel!.items[index].fee} ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                              Row(
                                children: [
                                  Text('${AppLocalizations.translate(StringsManager.status)}: ', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                                  Text(_cubit.newOrdersDataModel!.items[index].status!.replaceAll('_', ' '), style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.YELLOW)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppSizesDouble.s5,),
                        Center(child: DefaultRoundedIconButton(onPressed: () =>  Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.representativeOrderDetails, arguments: _cubit.newOrdersDataModel!.items[index]))), icon: IconsManager.rightArrow,))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async => await FlutterPhoneDirectCaller.callNumber(_cubit.newOrdersDataModel!.items[index].user!.phone),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.COLUMBIA_BLUE,
                              shape: RoundedRectangleBorder(),
                            ),
                            child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.call), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.WHITE),)),
                          ),
                        ),
                        Expanded(
                          child: state is RepresentativeGetOrderDetailsLoadingState && isOrigin && navigationId != null && navigationId == int.parse(_cubit.newOrdersDataModel!.items[index].id!)? Center(child: CircularProgressIndicator(backgroundColor: ColorsManager.GREY1),):
                          ElevatedButton(
                            onPressed: () {
                              isOrigin = true;
                              navigationId = int.parse(_cubit.newOrdersDataModel!.items[index].id!);
                              context.read<RepresentativeCubit>().getOrderDetails(navigationId!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.SOFT_GREEN,
                              shape: RoundedRectangleBorder(),
                            ),
                            child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.origin), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.WHITE),)),
                          ),
                        ),
                        Expanded(
                          child: state is RepresentativeGetOrderDetailsLoadingState && !isOrigin && navigationId != null && navigationId == int.parse(_cubit.newOrdersDataModel!.items[index].id!)?Center(child: CircularProgressIndicator(backgroundColor: ColorsManager.GREY1,),):
                          ElevatedButton(
                            onPressed: () {
                              isOrigin = false;
                              navigationId = int.parse(_cubit.newOrdersDataModel!.items[index].id!);
                              context.read<RepresentativeCubit>().getOrderDetails(navigationId!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.SOFT_RED,
                              shape: RoundedRectangleBorder(),
                            ),
                            child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.destination), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.WHITE),)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, state) => SizedBox(height: AppSizesDouble.s20,),
          itemCount: _cubit.newOrdersDataModel!.items.length
        ),
      ),
    );
  }
}
