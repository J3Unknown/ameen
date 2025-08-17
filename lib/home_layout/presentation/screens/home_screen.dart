import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
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
  void initState() {
    if(Repo.profileDataModel == null){
      context.read<MainCubit>().getProfile();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: MainCubit.get(context),
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p15),
        child: ConditionalBuilder(
          condition: Repo.profileDataModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator(),),
          builder: (context) => Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AssetsManager.logo, width: AppSizesDouble.s80,),
                  Spacer(),
                  DefaultRoundedIconButton(
                    onPressed: (){},
                    icon: IconsManager.notificationIcon,
                  )
                ],
              ),
              if(AppConstants.isAuthenticated)
              Align(alignment: AlignmentDirectional.centerStart, child: Text('${AppLocalizations.translate(StringsManager.hello)} ${Repo.profileDataModel!.name}')),
              if(!AppConstants.isAuthenticated)
              Align(alignment: AlignmentDirectional.centerStart, child: Text(AppLocalizations.translate(StringsManager.helloGuest))),
              Align(alignment: AlignmentDirectional.centerStart, child: Text(AppLocalizations.translate(StringsManager.welcomeToAmeen))),
              SizedBox(height: AppSizesDouble.s20,),
              Row(
                children: [
                  DefaultHomeCard(
                    title: StringsManager.itemDelivery,
                    image: AssetsManager.itemDelivery,
                    onTap: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.itemDelivery))),
                  ),
                  SizedBox(width: AppSizesDouble.s10,),
                  DefaultHomeCard(
                    title: StringsManager.sahlRequest,
                    image: AssetsManager.sahlRequest,
                    onTap: () {
                      if(false){
                        Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.sahl)));
                      } else {
                        Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.civilIdCheck)));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSizesDouble.s10,),
              InkWell(
                onTap: (){}, //TODO: Link with image redirecting action
                child: Container(
                  width: double.infinity,
                  height: AppSizesDouble.s100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizesDouble.s11),
                    image: DecorationImage(image: NetworkImage(AppConstants.basePlaceholderImage), fit: BoxFit.cover)
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s10,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(AppPaddings.p10),
                  decoration: BoxDecoration(
                    // color: ColorsManager.GREY1,
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
                          TextButton(onPressed: () => MainCubit.get(context).changeBottomNavBarIndex(AppSizes.s1), child: Text(AppLocalizations.translate(StringsManager.more), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY),))
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => IntrinsicHeight(
                            child: Container(
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
                                        Text('this is a very big title and it has to reach the end of the element', maxLines: AppSizes.s3, overflow: TextOverflow.ellipsis,),
                                        SizedBox(height: AppSizesDouble.s10,),
                                        Text(DateFormat('EEE dd, MMM, yyyy').format(DateTime.now()), style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsManager.DARK_GREY),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: Text('In Delivery', style: Theme.of(context).textTheme.titleSmall,),
                                  ),
                                  Icon(IconsManager.downArrow)
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s10,),
                          itemCount: 10
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}