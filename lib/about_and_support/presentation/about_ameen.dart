import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/strings_manager.dart';

class AboutAmeen extends StatefulWidget {
  const AboutAmeen({super.key});

  @override
  State<AboutAmeen> createState() => _AboutAmeenState();
}

class _AboutAmeenState extends State<AboutAmeen> {

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
          title: Text(AppLocalizations.translate(StringsManager.aboutAmeen), style: Theme.of(context).textTheme.headlineSmall,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppPaddings.p20),
          child: ConditionalBuilder(
            condition: Repo.aboutUsAndSupportDataModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator(),),
            builder: (context) => Text(
              Repo.aboutUsAndSupportDataModel!.description
            ),
          ),
        ),
      ),
    );
  }
}
