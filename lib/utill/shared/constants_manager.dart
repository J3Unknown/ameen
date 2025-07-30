import 'package:flutter/cupertino.dart';

class AppConstants{
  static const String imagePath = 'assets/image/';
  static const String baseUrl = ''; //TODO: provide the base req url

  static const String basePlaceholderImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHnKw8zTPIFvZRGE-bMtIlRXjsUW2BDyw9Pw&s';
  static Size screenSize(context) => MediaQuery.of(context).size;

  //* caches
  static bool isAuthenticated = false;
  static bool isGuest = true;
  static String locale = 'EN';

  static String token = '';
}