import 'package:flutter/material.dart';

interface class AddressBaseModel {
  void request(BuildContext context, int regionId, int cityId, String block, String building, String floor, String landmark, String street){}
}