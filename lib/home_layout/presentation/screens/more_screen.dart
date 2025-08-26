import 'package:ameen/Repo/repo.dart';
import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/auth/cubit/auth_cubit_state.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utill/local/localization/app_localization.dart';
import '../../../utill/shared/strings_manager.dart';
import '../../../utill/shared/values_manager.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitStates>(
      listener: (context, state) {
        if(state is AuthLogoutSuccessState){
          clearCaches();
          context.read<MainCubit>().screenIndex = 0;
          context.read<MainCubit>().itemsDataModel = null;
          Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.languageScreen)), (route) => false);
        }
      },
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppPaddings.p15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.translate(StringsManager.more), style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppSizesDouble.s50,),
                if(AppConstants.isGuest)
                Center(child: Text(AppLocalizations.translate(StringsManager.welcomeGuest), style: Theme.of(context).textTheme.headlineSmall,)),
                if(AppConstants.isAuthenticated || AppConstants.isRepresentativeAuthenticated)
                ConditionalBuilder(
                  condition: Repo.profileDataModel != null,
                  fallback: (context) => Center(child: CircularProgressIndicator(),),
                  builder: (context) => Center(child: Text('${AppLocalizations.translate(StringsManager.welcome)} ${Repo.profileDataModel!.name}', style: Theme.of(context).textTheme.headlineSmall,))),
                SizedBox(height: AppSizesDouble.s20,),
                if(AppConstants.isGuest)
                DefaultButton(
                  title: StringsManager.login,
                  onPressed: () {
                    context.read<MainCubit>().screenIndex = 0;
                    navigateToAuth(context, route: Routes.languageScreen);
                  },
                  borderRadius: AppSizesDouble.s11,
                ),
                if(AppConstants.isAuthenticated || AppConstants.isRepresentativeAuthenticated)
                DefaultButton(
                  title: StringsManager.logout,
                  isLoading: state is AuthLogoutLoadingState,
                  onPressed: (){
                    AuthCubit.get(context).logout(isDelivery: AppConstants.isAuthenticated?false:true);
                  },
                  borderRadius: AppSizesDouble.s11,
                  hasBorder: true,
                  backgroundColor: ColorsManager.WHITE,
                  foregroundColor: ColorsManager.RED,
                ),
                SizedBox(height: AppSizesDouble.s30,),
                DefaultProfileTile(
                  title: StringsManager.profile,
                  icon: AssetsManager.profile,
                  onTap: () {
                    if(AppConstants.isAuthenticated || AppConstants.isRepresentativeAuthenticated){
                      Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.profile)));
                    } else {
                      showDialog(context: context, builder: (context) => LoginAlert());
                    }
                  },
                ),
                if(!AppConstants.isRepresentativeAuthenticated)
                SizedBox(height: AppSizesDouble.s10,),
                if(!AppConstants.isRepresentativeAuthenticated)
                DefaultProfileTile(
                  title: StringsManager.myOrders,
                  icon: AssetsManager.myOrders,
                  onTap: () {
                    if(AppConstants.isAuthenticated){
                      MainCubit.get(context).changeBottomNavBarIndex(AppSizes.s1);
                    } else {
                      showDialog(context: context, builder: (context) => LoginAlert());
                    }
                  }
                ),
                SizedBox(height: AppSizesDouble.s10,),
                DefaultProfileTile(
                  title: StringsManager.language,
                  icon: AssetsManager.language,
                  onTap: () => showDialog(context: context, builder: (context) => LanguageAlert())
                ),
                SizedBox(height: AppSizesDouble.s10,),
                DefaultProfileTile(
                  title: StringsManager.support,
                  icon: AssetsManager.support,
                  onTap: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.support))) //TODO: Keep until deciding if can be accessed without authentication
                ),
                SizedBox(height: AppSizesDouble.s10,),
                DefaultProfileTile(
                  title: StringsManager.termsAndConditions,
                  icon: AssetsManager.termsAndConditions,
                  onTap: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.termsAndConditions)))
                ),
                SizedBox(height: AppSizesDouble.s10,),
                DefaultProfileTile(
                  title: StringsManager.aboutAmeen,
                  icon: AssetsManager.aboutUs,
                  onTap: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.aboutUs)))
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultProfileTile extends StatelessWidget {
  const DefaultProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap
  });

  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(AppLocalizations.translate(title)),
          Spacer(),
          Icon(IconsManager.rightArrow)
        ],
      ),
      leading: SvgPicture.asset(icon),
      onTap: onTap,
    );
  }
}
