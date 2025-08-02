import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../utill/local/localization/app_localization.dart';
import '../../../utill/shared/strings_manager.dart';
import '../../../utill/shared/values_manager.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.translate(StringsManager.myOrders), style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppSizesDouble.s10,),
            Container(
              decoration: BoxDecoration(
                color: ColorsManager.PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(AppSizesDouble.s15)
              ),
              padding: EdgeInsets.all(AppPaddings.p20),
              height: AppSizesDouble.s150,
              width: double.infinity,
              child: Column(
                children: [
                  SvgPicture.asset(AssetsManager.wallet, colorFilter: ColorFilter.mode(ColorsManager.WHITE, BlendMode.srcIn),),
                  SizedBox(height: AppSizesDouble.s10,),
                  Text(AppLocalizations.translate(StringsManager.yourWalletBalance), style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.WHITE),),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('3000', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.WHITE),),
                      SizedBox(width: AppSizesDouble.s10,),
                      Text(AppLocalizations.translate(StringsManager.kwd), style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorsManager.WHITE),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizesDouble.s20,),
            Center(
              child: DefaultButton(
                title: StringsManager.addBalance,
                hasBorder: true,
                backgroundColor: ColorsManager.WHITE,
                borderColor: ColorsManager.PRIMARY_COLOR,
                foregroundColor: ColorsManager.PRIMARY_COLOR,
                borderRadius: AppSizesDouble.s15,
                width: AppConstants.screenSize(context).width / AppSizes.s2,
                onPressed: (){},
              ),
            ),
            SizedBox(height: AppSizesDouble.s30,),
            Text(AppLocalizations.translate(StringsManager.transactions), style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppSizesDouble.s20,),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(AppPaddings.p20),
                  decoration: BoxDecoration(
                    color: ColorsManager.GREY1,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s15),
                  ),
                  height: AppSizesDouble.s120,
                  child: Row(
                    children: [
                      Expanded(child: SizedBox(),),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${index + 11} ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DEEP_BLUE),),
                            Text('Balance Charge', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DEEP_BLUE),),
                            Text(DateFormat('dd - MM - yyyy hh:mm a').format(DateTime.now()), style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DEEP_BLUE),)
                          ],
                        ),
                      ),
                      DefaultRoundedIconButton(onPressed: (){}, icon: IconsManager.downArrow, borderColor: ColorsManager.GREEN, iconColor: ColorsManager.GREEN,),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s20,),
                itemCount: 10
              )
            )
          ],
        ),
      ),
    );
  }
}
