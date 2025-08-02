import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

import '../../../utill/local/localization/app_localization.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPaddings.p15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.translate(StringsManager.myOrders), style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: AppSizesDouble.s10,),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => DefaultItemCard(index: index),
              separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s15,),
              itemCount: 10
            )
          )
        ],
      ),
    );
  }
}

