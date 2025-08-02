import 'package:ameen/payment/data/payment_result_arguments.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/assets_manager.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _couponController = TextEditingController();
  int selectedPayment = 0;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.payment), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPaddings.p15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.translate(StringsManager.orderDetails), style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: AppSizesDouble.s10,),
            Row(
              children: [
                Text(AppLocalizations.translate(StringsManager.totalItems), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY)),
                Spacer(),
                Text(AppLocalizations.translate(StringsManager.itemDelivery), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: AppSizesDouble.s15,),
            Row(
              children: [
                Text(AppLocalizations.translate(StringsManager.subTotal), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY)),
                Spacer(),
                Text('30 ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: AppSizesDouble.s15,),
            Row(
              children: [
                Text(AppLocalizations.translate(StringsManager.shippingCharge), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY)),
                Spacer(),
                Text('1.5 ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREY, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: AppSizesDouble.s35,
              child: Divider(height: AppSizesDouble.s1, color: ColorsManager.DARK_GREY, thickness: AppSizesDouble.s1,),
            ),
            Row(
              children: [
                Text(AppLocalizations.translate(StringsManager.bagTotal), style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREEN)),
                Spacer(),
                Text('30 ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.DARK_GREEN, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: AppSizesDouble.s25,),
            Text(AppLocalizations.translate(StringsManager.couponCodes), style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: AppSizesDouble.s10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizesDouble.s5),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.COLOR_LIGHT_BLACK,
                    offset: Offset(AppSizesDouble.s0, AppSizesDouble.s0),
                    spreadRadius: AppSizesDouble.s0,
                    blurRadius: AppSizesDouble.s3,
                    blurStyle: BlurStyle.outer
                  )
                ]
              ),
              child: TextFormField(
                controller: _couponController,
                cursorColor: ColorsManager.PRIMARY_COLOR,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizesDouble.s5),
                    borderSide: BorderSide(color: ColorsManager.DARK_GREY),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizesDouble.s5),
                    borderSide: BorderSide(color: ColorsManager.PRIMARY_COLOR),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPaddings.p4),
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.PRIMARY_COLOR,
                        foregroundColor: ColorsManager.WHITE,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizesDouble.s5)
                        )
                      ),
                      child: Text(AppLocalizations.translate(StringsManager.apply)),
                    ),
                  )
                ),
              ),
            ),
            SizedBox(height: AppSizesDouble.s25,),
            Text(AppLocalizations.translate(StringsManager.payment), style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultRadioTile(
              icon: AssetsManager.creditCard,
              title: StringsManager.creditCardOrDebitCard,
              value: AppSizes.s0,
              borderRadius: AppSizesDouble.s10,
              groupValue: selectedPayment,
              onChanged: (value){
                setState(() {
                  selectedPayment = value;
                });
              }
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultRadioTile(
              icon: AssetsManager.creditCard,
              title: StringsManager.knet,
              value: AppSizes.s1,
              borderRadius: AppSizesDouble.s10,
              groupValue: selectedPayment,
              onChanged: (value){
                setState(() {
                  selectedPayment = value;
                });
              }
            ),
            SizedBox(height: AppSizesDouble.s10,),
            DefaultRadioTile(
              icon: AssetsManager.creditCard,
              title: StringsManager.wallet,
              value: AppSizes.s2,
              borderRadius: AppSizesDouble.s10,
              groupValue: selectedPayment,
              onChanged: (value){
                setState(() {
                  selectedPayment = value;
                });
              }
            ),
            SizedBox(height: AppSizesDouble.s35,),
            DefaultButton(
              title: StringsManager.confirm,
              onPressed: (){
                Navigator.pushReplacement(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.paymentResult, arguments: PaymentResultArguments(false))));
              }
            )
          ],
        ),
      ),
    );
  }
}
