import 'package:ameen/Repo/repo.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../utill/local/localization/app_localization.dart';
import '../../../../utill/shared/BaseComponent.dart';
import '../../../../utill/shared/assets_manager.dart';
import '../../../../utill/shared/constants_manager.dart';
import '../../../../utill/shared/icons_manager.dart';
import '../../../../utill/shared/strings_manager.dart';
import '../../../../utill/shared/values_manager.dart';
import '../../cubit/representative_cubit.dart';

class RepresentativeHome extends StatefulWidget {
  const RepresentativeHome({super.key});

  @override
  State<RepresentativeHome> createState() => _RepresentativeHomeState();
}

class _RepresentativeHomeState extends State<RepresentativeHome> {

  late RepresentativeCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<RepresentativeCubit>();
    if(_cubit.newOrdersDataModel == null){
      _cubit.getNewOrders();
    }
    if(_cubit.deliveredOrdersDataModel == null){
      _cubit.getDeliveredOrders();
    }
    if(_cubit.cancelledOrdersDataModel == null){
      _cubit.getCancelledOrders();
    }
    _getCurrentLocation();
  }

  bool locationServiceEnabled = false;
  bool permissionGranted = false;

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
        showSnackBar(context, 'Please give the permission, to be able to proceed in this action');
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
      if(mounted){
        showSnackBar(context, 'Please give the permission, to be able to use maps');
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    RepresentativeCubit cubit = RepresentativeCubit.get(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Padding(
        padding: EdgeInsets.all(AppSizesDouble.s20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AssetsManager.logo, width: AppSizesDouble.s80,),
                Spacer(),
                DefaultRoundedIconButton(
                  onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.notifications))),
                  icon: IconsManager.notificationIcon,
                )
              ],
            ),
            ConditionalBuilder(
              condition: Repo.profileDataModel != null,
              fallback: (context) => Center(child: CircularProgressIndicator(),),
              builder: (context) => Align(alignment: AlignmentDirectional.centerStart, child: Text('${AppLocalizations.translate(StringsManager.hello)} ${Repo.profileDataModel!.name}'))
            ),
            Align(alignment: AlignmentDirectional.centerStart, child: Text(AppLocalizations.translate(StringsManager.welcomeToAmeen))),
            SizedBox(height: AppSizesDouble.s20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.screenSize(context).width / AppSizes.s50),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        cubit.changeOrderTypeIndex(AppSizes.s0);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cubit.ordersIndex == AppSizes.s0?ColorsManager.PRIMARY_COLOR:ColorsManager.WHITE,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizesDouble.s5),
                            bottomRight: Radius.circular(AppSizesDouble.s11),
                          ),
                          side: cubit.ordersIndex == 0?BorderSide(color: ColorsManager.BLACK):BorderSide()
                        ),
                      ),
                      child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.newOrders), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: cubit.ordersIndex == 0?ColorsManager.WHITE:ColorsManager.BLACK),)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                          cubit.changeOrderTypeIndex(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cubit.ordersIndex == 1?ColorsManager.PRIMARY_COLOR:ColorsManager.WHITE,
                        shape: RoundedRectangleBorder(
                            side: cubit.ordersIndex == 1?BorderSide(color: ColorsManager.BLACK):BorderSide()
                        ),
                      ),
                      child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.delivered), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: cubit.ordersIndex == 1?ColorsManager.WHITE:ColorsManager.BLACK),)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        cubit.changeOrderTypeIndex(2);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cubit.ordersIndex == 2?ColorsManager.PRIMARY_COLOR:ColorsManager.WHITE,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(AppSizesDouble.s11),
                            topRight: Radius.circular(AppSizesDouble.s5),
                          ),
                          side: cubit.ordersIndex == 2?BorderSide(color: ColorsManager.BLACK):BorderSide()
                        ),
                      ),
                      child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.cancelled), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: cubit.ordersIndex == 2?ColorsManager.WHITE:ColorsManager.BLACK),)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizesDouble.s20,),
            Expanded(
              child: cubit.homeScreens[cubit.ordersIndex]
            )
          ],
        ),
      ),
    );
  }
}
