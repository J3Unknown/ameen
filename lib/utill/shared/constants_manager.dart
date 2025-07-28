import 'package:flutter/cupertino.dart';

class AppConstants{
  static const String imagePath = 'assets/image/';

  static Size screenSize(context) => MediaQuery.of(context).size;

  static bool isAuthenticated = false;
  static bool isGuest = true;
}