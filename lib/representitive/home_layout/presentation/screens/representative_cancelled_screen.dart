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

class RepresentativeCancelledScreen extends StatefulWidget {
  const RepresentativeCancelledScreen({super.key});

  @override
  State<RepresentativeCancelledScreen> createState() => _RepresentativeCancelledScreenState();
}

class _RepresentativeCancelledScreenState extends State<RepresentativeCancelledScreen> {
  late final RepresentativeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RepresentativeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) => ConditionalBuilder(
        condition: _cubit.cancelledOrdersDataModel != null && _cubit.cancelledOrdersDataModel!.items.isNotEmpty,
        fallback: (context) {
          if(_cubit.cancelledOrdersDataModel != null && _cubit.cancelledOrdersDataModel!.items.isEmpty){
            return Center(child: Text(AppLocalizations.translate(StringsManager.noOrdersYet)),);
          }
          return Center(child: CircularProgressIndicator(),);
        },
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
                        Text(_cubit.cancelledOrdersDataModel!.items[index].title??'', style: Theme.of(context).textTheme.labelLarge, maxLines: 2, overflow: TextOverflow.ellipsis,),
                        SizedBox(height: AppSizesDouble.s10,),
                        Text('${AppLocalizations.translate(StringsManager.cancelledTime)}: ${DateFormat('EEE dd, MMM, yyyy').format(_cubit.cancelledOrdersDataModel!.items[index].cancellationTime != null?DateTime.parse(_cubit.cancelledOrdersDataModel!.items[index].cancellationTime!):DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                        Text('${AppLocalizations.translate(StringsManager.cancellationReason)}: ${AppLocalizations.translate(_cubit.cancelledOrdersDataModel!.items[index].cancellationReason??'unknown')}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
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
