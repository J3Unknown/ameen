import 'dart:io';

import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/home_layout/presentation/screens/home_screen.dart';
import 'package:ameen/home_layout/presentation/screens/more_screen.dart';
import 'package:ameen/home_layout/presentation/screens/orders_screen.dart';
import 'package:ameen/home_layout/presentation/screens/wallet_screen.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
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
}