import 'dart:developer';

import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utill/local/localization/app_localization.dart';

class OrdersScreen extends StatefulWidget{
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with AutomaticKeepAliveClientMixin{
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (_scrollController.position.pixels + 150 >= (_scrollController.position.maxScrollExtent)) {
      if(context.read<MainCubit>().hasMore){
        context.read<MainCubit>().getDeliveryItems(loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(AppPaddings.p15),
      child: BlocBuilder(
        bloc: MainCubit.get(context),
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.translate(StringsManager.myOrders), style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppSizesDouble.s10,),
            Expanded(
              child: ConditionalBuilder(
                fallback: (context){
                  if(MainCubit.get(context).itemsDataModel == null){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Center(child: Text(AppLocalizations.translate(StringsManager.noOrdersYet)),);
                },
                condition: MainCubit.get(context).itemsDataModel != null && MainCubit.get(context).itemsDataModel!.items.isNotEmpty,
                builder: (context) => ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) => DefaultItemCard(item: MainCubit.get(context).itemsDataModel!.items[index],),
                  separatorBuilder: (context, index) => SizedBox(height: AppSizesDouble.s15,),
                  itemCount: MainCubit.get(context).itemsDataModel!.items.length
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

