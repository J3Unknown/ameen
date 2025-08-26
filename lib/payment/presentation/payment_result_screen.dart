import 'package:ameen/payment/data/payment_result_arguments.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentResultScreen extends StatefulWidget {
  const PaymentResultScreen({super.key, required this.arguments});
  final PaymentResultArguments arguments;

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        leadingWidth: AppSizesDouble.s0,
        title: Text(AppLocalizations.translate(StringsManager.payment), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.p20),
        child: widget.arguments.isSuccess?
        Column(
          children: [
            Expanded(flex: AppSizes.s2, child: Center(child: SvgPicture.asset(AssetsManager.paymentSuccess))),
            Expanded(
              child: Column(
                children: [
                  FittedBox(child: Text(AppLocalizations.translate(StringsManager.orderConfirmationMessage), style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorsManager.DARK_GREEN),)),
                  SizedBox(height: AppSizesDouble.s10,),
                  Text('${AppLocalizations.translate(StringsManager.yourOrderCode)} #${widget.arguments.orderNo}', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY),),
                  Text(AppLocalizations.translate(StringsManager.thanksMessage), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                ],
              ),
            ),
            Expanded(
              flex: AppSizes.s2,
              child: Column(
                children: [
                  DefaultButton(
                    title: AppLocalizations.translate(StringsManager.home),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false);
                    }
                  ),
                  SizedBox(height: AppSizesDouble.s20,),
                  DefaultButton(
                    title: AppLocalizations.translate(StringsManager.trackOrder),
                    backgroundColor: ColorsManager.WHITE,
                    foregroundColor: ColorsManager.RED,
                    hasBorder: true,
                    onPressed: (){}
                  ),
                ],
              ),
            )
          ],
        ): //TODO: Change the static order number
        Column(
          children: [
            Expanded(flex: AppSizes.s2, child: Center(child: SvgPicture.asset(AssetsManager.paymentFailed))),
            Expanded(
              child: Column(
                children: [
                  FittedBox(child: Text(AppLocalizations.translate(StringsManager.ops), style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorsManager.RED),)),
                  SizedBox(height: AppSizesDouble.s10,),
                  Text(AppLocalizations.translate(StringsManager.orderConfirmationErrorMessage), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY),),
                ],
              ),
            ),
            Expanded(
              flex: AppSizes.s2,
              child: Column(
                children: [
                  DefaultButton(
                    title: AppLocalizations.translate(StringsManager.home),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.home)), (route) => false);
                    }
                  ),
                  SizedBox(height: AppSizesDouble.s20,),
                  DefaultButton(
                    title: AppLocalizations.translate(StringsManager.tryAgain),
                    backgroundColor: ColorsManager.WHITE,
                    foregroundColor: ColorsManager.RED,
                    hasBorder: true,
                    onPressed: () => Navigator.pop(context)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
