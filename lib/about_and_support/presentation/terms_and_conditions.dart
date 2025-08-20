import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/repo.dart';
import '../../home_layout/cubit/main_cubit.dart';
import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {

  @override
  void initState() {
    super.initState();
    if(Repo.aboutUsAndSupportDataModel == null){
      context.read<MainCubit>().getAboutUs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: MainCubit.get(context),
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.translate(StringsManager.termsAndConditions), style: Theme.of(context).textTheme.headlineSmall,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppPaddings.p20),
          child: ConditionalBuilder(
            condition: Repo.aboutUsAndSupportDataModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator(),),
            builder: (context) => Column(
              children: [
                Text(
                  Repo.aboutUsAndSupportDataModel!.terms
                ),
                Text(
                  Repo.aboutUsAndSupportDataModel!.privacy
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
