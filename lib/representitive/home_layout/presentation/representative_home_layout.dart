import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utill/shared/BaseComponent.dart';

class RepresentativeHomeLayout extends StatefulWidget {
  const RepresentativeHomeLayout({super.key});

  @override
  State<RepresentativeHomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<RepresentativeHomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: RepresentativeCubit.get(context),
      builder: (context, state) {
        RepresentativeCubit cubit = RepresentativeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: cubit.layoutScreens[cubit.screenIndex],
            bottomNavigationBar: CustomNavbar(cubit: cubit),
          ),
        );
      },
    );
  }
}
