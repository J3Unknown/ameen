import 'dart:developer';
import 'dart:io';

import 'package:ameen/Repo/about_us_and_support_data_model.dart';
import 'package:ameen/Repo/cities_and_regions_data_model.dart';
import 'package:ameen/Repo/pair_of_id_and_name.dart';
import 'package:ameen/Repo/profile_data_model.dart';
import 'package:ameen/Repo/repo.dart';
import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/home_layout/data/home_data_model.dart';
import 'package:ameen/home_layout/presentation/screens/home_screen.dart';
import 'package:ameen/home_layout/presentation/screens/more_screen.dart';
import 'package:ameen/home_layout/presentation/screens/orders_screen.dart';
import 'package:ameen/home_layout/presentation/screens/wallet_screen.dart';
import 'package:ameen/item_delivery_screen/data/address_data_model.dart';
import 'package:ameen/item_delivery_screen/data/categories_data_model.dart';
import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/network/dio.dart';
import 'package:ameen/utill/network/end_points.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/strings_manager.dart';


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

  final ImagePicker _imagePicker = ImagePicker();
  List<File> adImagesList = [];
  void pickItemDeliveryImages(context) async{
    emit(MainPickItemDeliveryImagesLoadingState());
    int remaining = 5 - adImagesList.length;
    final List<XFile> selectedImages = [];
    if(remaining == 0) return;
    if(remaining == 1){
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(image != null) selectedImages.add(image);
    }else if(remaining >= 1){
      final List<XFile>? images = await _imagePicker.pickMultiImage(limit: remaining);
      if(images != null) selectedImages.addAll(images);
    }
    if(selectedImages.isNotEmpty){
      final List<String> allowedExtensions = AppConstants.supportedImageFormats;
      for(var e in selectedImages){
        if(adImagesList.length == 5) {
          showSnackBar(context, StringsManager.imagesLimit);
          emit(MainPickItemDeliveryImagesSuccessState());
          break;
        }
        File image = File(e.path);
        int fileSizeInBytes = await image.length();
        double fileSizeInMB = fileSizeInBytes * 2 / (1024 * 1024);
        if(fileSizeInMB < 1 && allowedExtensions.contains(e.name.split('.').last.toLowerCase())){
          adImagesList.add(image);
        } else {
          if(fileSizeInMB < 2){
            showSnackBar(context, '${AppLocalizations.translate(StringsManager.theImage)} ${e.name} ${AppLocalizations.translate(StringsManager.greaterThanOneMB)}');
          } else {
            showSnackBar(context, '${AppLocalizations.translate(StringsManager.theImage)} ${e.name} ${AppLocalizations.translate(StringsManager.unsupportedFormat)}');
          }
        }
      }
      emit(MainPickItemDeliveryImagesSuccessState());
    }
  }

  void getProfile(){
    if(AppConstants.isAuthenticated){
      emit(MainGetProfileLoadingState());
      DioHelper.getData(path: EndPoints.profile).then((value){
        Repo.profileDataModel = ProfileDataModel.fromJson(value.data[KeysManager.result]);
        emit(MainGetProfileSuccessState());
      });
    }
  }



  CitiesAndRegionsDataModel? cities;
  void getCities(){
    emit(MainGetCitiesLoadingState());
    DioHelper.getData(path: EndPoints.cities).then((value){
      cities = CitiesAndRegionsDataModel.fromJson(value.data);
      emit(MainGetCitiesSuccessState());
    });
  }

  CitiesAndRegionsDataModel? regions;
  void getRegions(int cityId){
    regions = null;
    emit(MainGetRegionsLoadingState());
    DioHelper.getData(path: EndPoints.regions, query: {KeysManager.id:cityId}).then((value){
      regions = CitiesAndRegionsDataModel.fromJson(value.data);
      emit(MainGetRegionsSuccessState());
    });
  }

  void deleteAccount(){
    emit(MainDeleteAccountLoadingState());
    DioHelper.deleteData(url: EndPoints.profile).then((value){
      emit(MainDeleteAccountSuccessState());
    });
  }

  void updateAccount(BuildContext context, String name, String phone, {String? email, String? password}){
    emit(MainDeleteAccountLoadingState());
    DioHelper.postData(
      url: EndPoints.editProfile,
      data: {
        KeysManager.name:name,
        KeysManager.phone:phone,
        if(email != null)KeysManager.email:email,
        if(password != null)KeysManager.password:password,
      }
    ).then((value){
      showSnackBar(context, StringsManager.accountUpdatedSuccessfully);
      emit(MainDeleteAccountSuccessState());
    });
  }

  HomeDataModel? homeDataModel;
  void getHome(){
    if(!AppConstants.isRepresentativeAuthenticated){
      emit(MainGetHomeLoadingState());
      DioHelper.getData(path: EndPoints.banners).then((value){
        homeDataModel = HomeDataModel.fromJson(value.data[KeysManager.result]);
        emit(MainGetHomeSuccessState());
      });
    }
  }

  CategoriesDataModel? categoriesDataModel;
  void getCategories(){
      emit(MainGetCategoriesLoadingState());
    DioHelper.getData(path: EndPoints.categories).then((value){
      categoriesDataModel = CategoriesDataModel.fromJson(value.data);
      categoriesDataModel!.category.add(PairOfIdAndName(-1, 'Other'));
      emit(MainGetCategoriesSuccessState());
    });
  }

  Map<String, dynamic> _getCityAndRegionNameById(int id, List<PairOfIdAndName> list){
    for (var e in list) {
      if (e.id == id) {
        return {'id': id, 'name': e.name};
      }
    }
    return {};
  }

  Address? destinationAddress;
  void createDestinationAddress({
    required int regionId,
    required int cityId,
    required String blockNo,
    required String street,
    required String buildingNo,
    required String floorNo,
    required String landmark,
  }){
    emit(MainCreateAddressLoadingState());
    DioHelper.postData(
      url: EndPoints.addAddress,
      data: {
        KeysManager.id:regionId,
        KeysManager.blockNo:blockNo,
        KeysManager.street:street,
        KeysManager.buildingNo:buildingNo,
        KeysManager.floorNo:floorNo,
        KeysManager.landmark:landmark
      }
    ).then((value){
      Map<String, dynamic> data = value.data[KeysManager.result];
      data['city'] = _getCityAndRegionNameById(cityId, cities!.objects);
      data['region'] = _getCityAndRegionNameById(regionId, regions!.objects);
      data['landmark'] = landmark;
      destinationAddress = Address.fromJson(data);
      emit(MainCreateAddressSuccessState(destinationAddress!));
    }).catchError((e){
      emit(MainCreateAddressErrorState());
    });
  }

  Address? originAddress;
  void createOriginAddress({
    required int regionId,
    required int cityId,
    required String blockNo,
    required String street,
    required String buildingNo,
    required String floorNo,
    required String landmark,
  }){
    emit(MainCreateAddressLoadingState());
    DioHelper.postData(
      url: EndPoints.addAddress,
      data: {
        KeysManager.id: regionId,
        KeysManager.blockNo: blockNo,
        KeysManager.street: street,
        KeysManager.buildingNo: buildingNo,
        KeysManager.floorNo: floorNo,
        KeysManager.landmark:landmark
      }
    ).then((value){
      Map<String, dynamic> data = value.data[KeysManager.result];
      data['city'] = _getCityAndRegionNameById(cityId, cities!.objects);
      data['region'] = _getCityAndRegionNameById(regionId, regions!.objects);
      data['landmark'] = landmark;
      originAddress = Address.fromJson(data);
      emit(MainCreateAddressSuccessState(originAddress!));
    });
  }

  ItemsDataModel? itemsDataModel;
  void getDeliveryItems({int page = 1}){
    if(AppConstants.isAuthenticated){
      emit(MainGetDeliveryItemsLoadingState());
      DioHelper.getData(path: EndPoints.orders, query: {KeysManager.page:page}).then((value){
        itemsDataModel = ItemsDataModel.fromJson(value.data[KeysManager.result]);
        emit(MainGetDeliveryItemsSuccessState());
      });
    }
  }

  DeliveryItem? createdItem;
  void createItemDelivery({
    required String title,
    required int categoryId,
    required String date,
    required int originAddressId,
    required int destinationAddressId,
    required double destinationAddressLat,
    required double destinationAddressLong,
    required double originAddressLat,
    required double originAddressLong,
    required String note,
  }) async{
    emit(MainCreateDeliveryItemsLoadingState());
    FormData data;

    List<MultipartFile> partImages = [];

    for(var i in adImagesList){
      final file = await MultipartFile.fromFile(
        i.path,
        filename: i.path.split('/').last
      );
      partImages.add(file);
    }
    log(date);
    data = FormData.fromMap({
      'title':title,
      'category_id':categoryId,
      'delivery_date_description':date,
      'origin_address_id':originAddressId,
      'destination_address_id':destinationAddressId,
      'origin_address_lat':originAddressLat,
      'origin_address_lng':originAddressLong,
      'destination_address_lat':destinationAddressLat,
      'destination_address_lng':destinationAddressLong,
      'payment_type':'cash',
      'payment_method':'COD',
      'note':note,
      'images[]':partImages
    });
    DioHelper.dio.post(
      EndPoints.orders,
      data: data,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
        contentType: 'multipart/form-data',
      ),
    ).then((value){
      if(value.data[KeysManager.success]){
        adImagesList = [];
        destinationAddress = null;
        originAddress = null;
        createdItem = DeliveryItem.fromJson(value.data[KeysManager.result]);
        emit(MainCreateDeliveryItemsSuccessState());
      } else {
        emit(MainCreateDeliveryItemsErrorState());
      }
    }).catchError((e){
      emit(MainCreateDeliveryItemsErrorState());
    });
  }

  void cancelOrder(int id){
    emit(MainCancelOrderLoadingState());
    DioHelper.postData(url: '${EndPoints.orders}/$id/${EndPoints.cancel}').then((value){
      emit(MainCancelOrderSuccessState());
    });
  }

  void sendReporting(int id, int experienceRating, int deliveryTimeRating, int deliveryAgentRating, String description){
    emit(MainSendReportingLoadingState());
    DioHelper.postData(
      url: '${EndPoints.orders}/$id/${EndPoints.rate}',
      data: {
        KeysManager.rateExperience:experienceRating,
        KeysManager.rateDeliveryTime:deliveryTimeRating,
        KeysManager.rateAgent:deliveryAgentRating,
        KeysManager.rateDescription:description
      }
    ).then((value){
      emit(MainSendReportingSuccessState());
      getDeliveryItems();
    });
  }

  void getAboutUs(){
    emit(MainGetAboutUsLoadingState());
    DioHelper.getData(path: EndPoints.aboutUs).then((value){
      Repo.aboutUsAndSupportDataModel = AboutUsAndSupportDataModel.fromJson(value.data[KeysManager.result]);
      emit(MainGetAboutUsSuccessState());
    });
  }
}