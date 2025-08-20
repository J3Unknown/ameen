import 'dart:developer';

import 'package:ameen/Repo/profile_data_model.dart';
import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/presentation/screens/more_screen.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit_states.dart';
import 'package:ameen/representitive/home_layout/presentation/screens/representative_cancelled_screen.dart';
import 'package:ameen/representitive/home_layout/presentation/screens/representative_delivered_screen.dart';
import 'package:ameen/utill/network/dio.dart';
import 'package:ameen/utill/network/end_points.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
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
    screenIndex = index;
    emit(RepresentativeChangeScreenStates());
  }

  void getProfile(){
    emit(RepresentativeGetProfileLoadingState());
    DioHelper.getData(isDelivery: true, path: EndPoints.profile).then((value){
      Repo.profileDataModel = ProfileDataModel.fromJson(value.data[KeysManager.result]);
      emit(RepresentativeGetProfileSuccessState());
    });
  }

  ItemsDataModel? newOrdersDataModel;
  void getNewOrders(){
    emit(RepresentativeGetNewOrdersLoadingStates());
    DioHelper.getData(isDelivery: true, path: EndPoints.orders, query: {KeysManager.tab:'new'}).then((value){
      if(value.data[KeysManager.success]??false){
        newOrdersDataModel = ItemsDataModel.fromJson(value.data[KeysManager.result]);
        emit(RepresentativeGetNewOrdersSuccessStates());
      } else {
        emit(RepresentativeGetNewOrdersErrorStates());
      }
    });
  }

  ItemsDataModel? deliveredOrdersDataModel;
  void getDeliveredOrders(){
    emit(RepresentativeGetDeliveredOrdersLoadingStates());
    DioHelper.getData(isDelivery: true, path: EndPoints.orders, query: {KeysManager.tab:'delivered'}).then((value){
      if(value.data[KeysManager.success]??false){
        deliveredOrdersDataModel = ItemsDataModel.fromJson(value.data[KeysManager.result]);
        emit(RepresentativeGetDeliveredOrdersSuccessStates());
      }
    });
  }

  ItemsDataModel? cancelledOrdersDataModel;
  void getCancelledOrders(){
    emit(RepresentativeGetCancelledOrdersLoadingStates());
    DioHelper.getData(isDelivery: true, path: EndPoints.orders, query: {KeysManager.tab:'canceled'}).then((value){
      if(value.data[KeysManager.success]??false){
        cancelledOrdersDataModel = ItemsDataModel.fromJson(value.data[KeysManager.result]);
        emit(RepresentativeGetCancelledOrdersSuccessStates());
      }
    });
  }

  void changeOutForDeliveryStatus(int id){
    emit(RepresentativeChangeOutForDeliveryStatusLoadingState());
    DioHelper.postData(url: '${EndPoints.orders}/$id/${EndPoints.outForDelivery}').then((value){
      getNewOrders();
      emit(RepresentativeChangeOutForDeliveryStatusSuccessState());
    });
  }

  void changeDeliveredStatus(int id){
    emit(RepresentativeChangeDeliveredStatusLoadingState());
    DioHelper.postData(url: '${EndPoints.orders}/$id/${EndPoints.delivered}').then((value){
      if(value.data[KeysManager.success]){
        emit(RepresentativeChangeDeliveredStatusSuccessState());
      } else {
        emit(RepresentativeChangeDeliveredStatusErrorState(value.data['msg']));
      }
    });
  }

  void cancelItem(int id){
    emit(RepresentativeCancelOrderLoadingState());
    DioHelper.postData(url: '${EndPoints.orders}/$id/${EndPoints.cancel}').then((value){
      emit(RepresentativeCancelOrderSuccessState());
    });
  }
}