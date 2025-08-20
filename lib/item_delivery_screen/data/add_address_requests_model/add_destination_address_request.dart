import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/item_delivery_screen/data/add_address_requests_model/address_base_model.dart';
import 'package:flutter/material.dart';

class AddDestinationAddressRequest implements AddressBaseModel{
  
  @override
  void request(BuildContext context, int regionId, int cityId, String block, String building, String floor, String landmark, String street) {
    MainCubit.get(context).createDestinationAddress(regionId: regionId, cityId: cityId, blockNo: block, street: street, buildingNo: building, floorNo: floor, landmark: landmark);
  }
  
}