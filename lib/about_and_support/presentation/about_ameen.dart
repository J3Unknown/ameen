import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return SafeArea(
      child: BlocBuilder(
        bloc: MainCubit.get(context),
        builder: (context, state) => Scaffold(
          body: ConditionalBuilder(
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
