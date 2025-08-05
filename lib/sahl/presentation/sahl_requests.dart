import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/icons_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utill/shared/routes_manager.dart';

class SahlRequests extends StatelessWidget {
  const SahlRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.sahlRequests), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AssetsManager.sahlId),
                SizedBox(width: AppSizesDouble.s10,),
                FittedBox(child: Text(AppLocalizations.translate('ID verification with Hawity'), style: Theme.of(context).textTheme.displaySmall,)),
                Spacer(),
                Icon(IconsManager.check)
              ],
            ),
            SizedBox(height: AppSizesDouble.s40,),
            Text(AppLocalizations.translate('requests'), style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),),
            SizedBox(height: AppSizesDouble.s20,),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s20,),
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(AppSizesDouble.s15),
                  decoration: BoxDecoration(
                    color: ColorsManager.GREY1,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s15),
                  ),
                  height: AppSizesDouble.s100,
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetsManager.license),
                      SizedBox(width: AppSizesDouble.s20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppLocalizations.translate('License Delivery')),
                          Text('${AppLocalizations.translate('Delivery Fee:')} 10 ${AppLocalizations.translate(StringsManager.kwd)}'),
                        ],
                      ),
                      Spacer(),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: AppSizesDouble.s120),
                        child: DefaultButton(
                          title: 'Proceed',
                          onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.sahlRequest))),
                          height: AppSizesDouble.s50,
                          isInfiniteWidth: false,
                          borderRadius: AppSizesDouble.s10,
                        )
                      )
                    ],
                  ),
                ),
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
