import 'package:flutter/material.dart';

import '../../../utill/local/localization/app_localization.dart';
import '../../../utill/shared/colors_manager.dart';
import '../../../utill/shared/values_manager.dart';

class DefaultHomeCard extends StatelessWidget {
  const DefaultHomeCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.image
  });

  final VoidCallback onTap;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(AppPaddings.p10),
            decoration: BoxDecoration(
                color: ColorsManager.PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(AppSizesDouble.s14)
            ),
            height: AppSizesDouble.s150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: AlignmentDirectional.centerEnd, child: Image.asset(image, width: AppSizesDouble.s65,)),
                Spacer(),
                Text(AppLocalizations.translate(title), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.WHITE),)
              ],
            ),
          )
      ),
    );
  }
}