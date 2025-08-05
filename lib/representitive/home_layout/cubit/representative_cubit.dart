import 'dart:developer';

import 'package:ameen/home_layout/presentation/screens/more_screen.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit_states.dart';
import 'package:ameen/representitive/home_layout/presentation/screens/representative_cancelled_screen.dart';
import 'package:ameen/representitive/home_layout/presentation/screens/representative_delivered_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/screens/representative_home.dart';
import '../presentation/screens/representative_new_orders_screen.dart';

class RepresentativeCubit extends Cubit<RepresentativeCubitStates>{
  RepresentativeCubit() : super(RepresentativeInitStates());

  static RepresentativeCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;
  int ordersIndex = 0;

  List<Widget> homeScreens = [
    RepresentativeNewOrdersScreen(),
    RepresentativeDeliveredScreen(),
    RepresentativeCancelledScreen(),
  ];

  List<Widget> layoutScreens = [
    RepresentativeHome(),
    MoreScreen()
  ];

  void changeOrderTypeIndex(int index){
    ordersIndex = index;
    emit(RepresentativeChangeScreenStates());
  }

  void changeBottomNavBarIndex(int index){
    log(index.toString());
    screenIndex = index;
    emit(RepresentativeChangeScreenStates());
  }

}