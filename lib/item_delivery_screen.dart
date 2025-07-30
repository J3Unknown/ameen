import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:flutter/material.dart';

class ItemDeliveryScreen extends StatefulWidget {
  const ItemDeliveryScreen({super.key});

  @override
  State<ItemDeliveryScreen> createState() => _ItemDeliveryScreenState();
}

class _ItemDeliveryScreenState extends State<ItemDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.itemDelivery), style: Theme.of(context).textTheme.headlineSmall,),
      ),
    );
  }
}
