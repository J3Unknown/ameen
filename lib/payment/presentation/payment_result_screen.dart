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
        leadingWidth: 0,
        title: Text(AppLocalizations.translate(StringsManager.payment), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.p20),
        child: widget.arguments.isSuccess? Column(
          children: [
            Expanded(flex: 2, child: Center(child: SvgPicture.asset(AssetsManager.paymentSuccess))),
            Expanded(
              child: Column(
                children: [
                  FittedBox(child: Text('YOUR ORDER WAS CONFIRMED!', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorsManager.DARK_GREEN),)),
                  SizedBox(height: AppSizesDouble.s10,),
                  Text('your order code: #2342342', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY),),
                  Text('Thank You for choosing our App!', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  DefaultButton(
                    title: 'Home',
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  ),
                  SizedBox(height: AppSizesDouble.s20,),
                  DefaultButton(
                    title: 'Track Order',
                    backgroundColor: ColorsManager.WHITE,
                    foregroundColor: ColorsManager.RED,
                    hasBorder: true,
                    onPressed: (){}
                  ),
                ],
              ),
            )
          ],
        ):Column(
          children: [
            Expanded(flex: 2, child: Center(child: SvgPicture.asset(AssetsManager.paymentFailed))),
            Expanded(
              child: Column(
                children: [
                  FittedBox(child: Text('OPS!', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorsManager.RED),)),
                  SizedBox(height: AppSizesDouble.s10,),
                  Text('Error while confirming your payment/order', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY),),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  DefaultButton(
                      title: 'Home',
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                  ),
                  SizedBox(height: AppSizesDouble.s20,),
                  DefaultButton(
                      title: 'TryAgain',
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
