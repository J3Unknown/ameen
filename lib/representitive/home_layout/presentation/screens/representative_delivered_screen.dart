import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../utill/local/localization/app_localization.dart';
import '../../../../utill/shared/assets_manager.dart';
import '../../../../utill/shared/colors_manager.dart';
import '../../../../utill/shared/strings_manager.dart';
import '../../../../utill/shared/values_manager.dart';

class RepresentativeDeliveredScreen extends StatefulWidget {
  const RepresentativeDeliveredScreen({super.key});

  @override
  State<RepresentativeDeliveredScreen> createState() => _RepresentativeDeliveredScreenState();
}

class _RepresentativeDeliveredScreenState extends State<RepresentativeDeliveredScreen> {
  late final RepresentativeCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<RepresentativeCubit>();
    if(_cubit.deliveredOrdersDataModel == null){
      _cubit.getDeliveredOrders();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) => ConditionalBuilder(
        fallback: (context) {
          if(_cubit.newOrdersDataModel != null && _cubit.newOrdersDataModel!.items.isEmpty){
            return Center(
              child: Text(AppLocalizations.translate(StringsManager.noOrdersYet)),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        condition: _cubit.deliveredOrdersDataModel != null && _cubit.deliveredOrdersDataModel!.items.isNotEmpty,
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) => IntrinsicHeight(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(AssetsManager.itemIcon),
                  SizedBox(width: AppSizesDouble.s7,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_cubit.deliveredOrdersDataModel!.items[index].title!, style: Theme.of(context).textTheme.labelLarge, maxLines: AppSizes.s2, overflow: TextOverflow.ellipsis,),
                        SizedBox(height: AppSizesDouble.s10,),
                        Text('${AppLocalizations.translate(StringsManager.clientDetails)}: ${_cubit.deliveredOrdersDataModel!.items[index].user!.name}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                        Text('${AppLocalizations.translate(StringsManager.orderFee)}: ${_cubit.deliveredOrdersDataModel!.items[index].fee} ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                        Text('${AppLocalizations.translate(StringsManager.deliveryDate)}: ${DateFormat('EEE dd, MMM, yyyy').format(_cubit.deliveredOrdersDataModel!.items[index].deliveryTime != null?DateTime.parse(_cubit.deliveredOrdersDataModel!.items[index].deliveryTime!):DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, state) => SizedBox(height: AppSizesDouble.s20,),
          itemCount: 5
        ),
      ),
    );
  }
}
