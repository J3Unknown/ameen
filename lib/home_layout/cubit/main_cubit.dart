import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/home_layout/presentation/screens/home_screen.dart';
import 'package:ameen/home_layout/presentation/screens/more_screen.dart';
import 'package:ameen/home_layout/presentation/screens/orders_screen.dart';
import 'package:ameen/home_layout/presentation/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainCubit extends Cubit<MainCubitStates>{
  MainCubit() : super(MainInitState());

  static MainCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    OrdersScreen(),
    WalletScreen(),
    MoreScreen()
  ];

  void changeBottomNavBarIndex(int index){
    screenIndex = index;
    emit(MainChangeNavigationBarIndexState());
  }

}