import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, state) => IntrinsicHeight(
        child: InkWell(
          onTap: (){
            Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.representativeOrderDetails)));
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
                          Text('This is a very big title which has to reach the end of the item', style: Theme.of(context).textTheme.labelLarge, maxLines: AppSizes.s2, overflow: TextOverflow.ellipsis,),
                          SizedBox(height: AppSizesDouble.s10,),
                          Text('${AppLocalizations.translate(StringsManager.deliveryDate)}: ${DateFormat('EEE dd, MMM, yyyy').format(DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)), //TODO: change the date into today's date
                          Text('${AppLocalizations.translate(StringsManager.orderFee)}: 12 ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                          Row(
                            children: [
                              Text('${AppLocalizations.translate(StringsManager.governance)}: ', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                              Text('Gov', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.YELLOW)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSizesDouble.s5,),
                    Center(child: DefaultRoundedIconButton(onPressed: () =>  Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.representativeOrderDetails))), icon: IconsManager.rightArrow,))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.COLUMBIA_BLUE,
                          shape: RoundedRectangleBorder(),
                        ),
                        child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.call), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.WHITE),)),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.SOFT_GREEN,
                          shape: RoundedRectangleBorder(),
                        ),
                        child: FittedBox(child: Text(AppLocalizations.translate(StringsManager.origin), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.WHITE),)),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){},
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
      itemCount: 5
    );
  }
}
