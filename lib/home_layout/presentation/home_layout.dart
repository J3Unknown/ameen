import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utill/shared/BaseComponent.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return BlocBuilder(
      bloc: cubit,
      builder:(context, state) => Scaffold(
        body: SafeArea(child: cubit.screens[cubit.screenIndex]),
        bottomNavigationBar: CustomNavbar(cubit: cubit)
      ),
    );
  }
}

