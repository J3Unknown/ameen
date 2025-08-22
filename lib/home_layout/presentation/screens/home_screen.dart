import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../utill/shared/BaseComponent.dart';
import '../widgets/default_home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: MainCubit.get(context),
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p15),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AssetsManager.logo, width: AppSizesDouble.s80,),
                Spacer(),
                DefaultRoundedIconButton(
                  onPressed: () {
                    if(AppConstants.isGuest){
                      showDialog(context: context, builder: (context) => LoginAlert());
                    } else {
                      Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.notifications)));
                    }
                  },
                  icon: IconsManager.notificationIcon,
                )
              ],
            ),
          if(AppConstants.isAuthenticated)
          ConditionalBuilder(
            condition: Repo.profileDataModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator(),),
            builder: (context) => Align(alignment: AlignmentDirectional.centerStart, child: Text('${AppLocalizations.translate(StringsManager.hello)} ${Repo.profileDataModel!.name}'))
          ),
            if(!AppConstants.isAuthenticated)
            Align(alignment: AlignmentDirectional.centerStart, child: Text(AppLocalizations.translate(StringsManager.helloGuest))),
            Align(alignment: AlignmentDirectional.centerStart, child: Text(AppLocalizations.translate(StringsManager.welcomeToAmeen))),
            SizedBox(height: AppSizesDouble.s20,),
            Row(
              children: [
                DefaultHomeCard(
                  title: StringsManager.itemDelivery,
                  image: AssetsManager.itemDelivery,
                  onTap: () {
                    if(AppConstants.isAuthenticated){
                      Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.itemDelivery)));
                    } else {
                      showDialog(context: context, builder: (context) => LoginAlert());
                    }
                  },
                ),
                SizedBox(width: AppSizesDouble.s10,),
                DefaultHomeCard(
                  title: StringsManager.sahlRequest,
                  image: AssetsManager.sahlRequest,
                  onTap: () {
                    showDialog(context: context, builder: (context) => NoteDialog(note: StringsManager.comingSoon));
                    // if(AppConstants.isAuthenticated){
                    //   // if(false){
                    //   //   //TODO: get the condition to switch between the routes
                    //   //   Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.sahl)));
                    //   // } else {
                    //   //   Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.civilIdCheck)));
                    //   // }
                    // } else {
                    //   showDialog(context: context, builder: (context) => LoginAlert());
                    // }
                  },
                ),
              ],
            ),
            SizedBox(height: AppSizesDouble.s10,),
            ConditionalBuilder(
              condition: MainCubit.get(context).homeDataModel != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => InkWell(
                // onTap: (){
                //   launchUrl(AppConstants.baseImageUrl + MainCubit.get(context).homeDataModel!.banners.name);
                // },
                child: Container(
                  width: double.infinity,
                  height: AppSizesDouble.s100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizesDouble.s11),
                    image: DecorationImage(image: NetworkImage(AppConstants.baseImageUrl + MainCubit.get(context).homeDataModel!.banners.name), fit: BoxFit.cover)
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSizesDouble.s10,),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(AppPaddings.p10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorsManager.GREY1,
                      ColorsManager.GREY1,
                      ColorsManager.GREY1,
                      ColorsManager.GREY1,
                      ColorsManager.GREY1.withValues(alpha: 0.7),
                      ColorsManager.GREY1.withValues(alpha: 0.3),
                      ColorsManager.GREY1.withValues(alpha: 0.1),
                    ]
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizesDouble.s11)),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(AppLocalizations.translate(StringsManager.myOrders), style: Theme.of(context).textTheme.labelLarge,),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            if(AppConstants.isAuthenticated){
                              MainCubit.get(context).changeBottomNavBarIndex(AppSizes.s1);
                            }  else {
                              showDialog(context: context, builder: (context) => LoginAlert());
                            }
                          },
                          child: Text(AppLocalizations.translate(StringsManager.more), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY),))
                      ],
                    ),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: MainCubit.get(context).itemsDataModel != null && MainCubit.get(context).itemsDataModel!.items.isNotEmpty,
                        fallback: (context) {
                          if((MainCubit.get(context).itemsDataModel != null && MainCubit.get(context).itemsDataModel!.items.isEmpty) || AppConstants.isGuest){
                            return Center(child: Text(AppLocalizations.translate(StringsManager.noOrdersYet)),);
                          }
                          return Center(child: CircularProgressIndicator(backgroundColor: ColorsManager.GREY1,),);
                        },
                        builder: (context) => ListView.separated(
                          itemBuilder: (context, index) => IntrinsicHeight(
                            child: DefaultDeliveryItemCard(item: MainCubit.get(context).itemsDataModel!.items[index],),
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s10,),
                          itemCount: MainCubit.get(context).itemsDataModel!.items.length
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultDeliveryItemCard extends StatelessWidget {
  const DefaultDeliveryItemCard({
    super.key,
    required this.item
  });

  final DeliveryItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: AppSizesDouble.s120,
      ),
      padding: EdgeInsets.all(AppPaddings.p10),
      decoration: BoxDecoration(
        color: ColorsManager.WHITE,
        borderRadius: BorderRadius.circular(AppSizesDouble.s20)
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title??'', maxLines: AppSizes.s3, overflow: TextOverflow.ellipsis,),
                SizedBox(height: AppSizesDouble.s10,),
                Text(DateFormat('EEE dd, MMM, yyyy').format(DateTime.parse(item.deliveryTime??'${DateTime.now()}')), style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsManager.DARK_GREY),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPaddings.p4),
            child: Text(item.status??'pending', style: Theme.of(context).textTheme.titleSmall,),
          ),
          Icon(getIcon(item.status??'pending'))
        ],
      ),
    );
  }

  IconData getIcon(String status){
    switch(status.toLowerCase()){
      case 'pending':
        return IconsManager.timer;
      default:
        return IconsManager.timer;
    }
  }
}