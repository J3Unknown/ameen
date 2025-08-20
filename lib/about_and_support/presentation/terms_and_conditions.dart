import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/repo.dart';
import '../../home_layout/cubit/main_cubit.dart';

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
    return SafeArea(
      child: BlocBuilder(
        bloc: MainCubit.get(context),
        builder: (context, state) => Scaffold(
          body: ConditionalBuilder(
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
