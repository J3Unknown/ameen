import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../utill/local/localization/app_localization.dart';
import '../../../../utill/shared/BaseComponent.dart';
import '../../../../utill/shared/assets_manager.dart';
import '../../../../utill/shared/colors_manager.dart';
import '../../../../utill/shared/icons_manager.dart';
import '../../../../utill/shared/strings_manager.dart';
import '../../../../utill/shared/values_manager.dart';

class RepresentativeCancelledScreen extends StatelessWidget {
  const RepresentativeCancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, state) => IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10, vertical: AppPaddings.p15),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorsManager.GREY1,
                borderRadius: BorderRadius.circular(AppSizesDouble.s15)
            ),
            constraints: BoxConstraints(
              maxHeight: AppSizesDouble.s230,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AssetsManager.itemIcon),
                SizedBox(width: AppSizesDouble.s7,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('This is a very big title which has to reach the end of the item', style: Theme.of(context).textTheme.labelLarge, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      SizedBox(height: AppSizesDouble.s10,),
                      Text('${AppLocalizations.translate(StringsManager.deliveryDate)} ${DateFormat('EEE dd, MMM, yyyy').format(DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)), //TODO: change the date into today's date
                      Text('${AppLocalizations.translate(StringsManager.orderFee)} 12 ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                      Row(
                        children: [
                          Text('${AppLocalizations.translate(StringsManager.governance)}: ', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                          Text('Gov', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.YELLOW)),
                        ],
                      ),
                      Text('${AppLocalizations.translate('Cancelled Time')} ${DateFormat('EEE dd, MMM, yyyy').format(DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)), //TODO: change the date into today's date
                      Text(AppLocalizations.translate('Cancelled by Admin or User or Agent'), style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)), //TODO: change the date into today's date
                    ],
                  ),
                ),
                // SizedBox(width: AppSizesDouble.s5,),
                // Center(child: DefaultRoundedIconButton(onPressed: (){}, icon: IconsManager.rightArrow,))
              ],
            ),
          ),
        ),
        separatorBuilder: (context, state) => SizedBox(height: AppSizesDouble.s20,),
        itemCount: 5
    );
  }
}
