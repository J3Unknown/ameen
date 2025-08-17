import 'package:flutter/cupertino.dart';

class AppConstants{
  static const String imagePath = 'assets/image/';
  static const String baseUrl = 'https://ameenkw.com/ameen/public/api/';

  static const String basePlaceholderImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHnKw8zTPIFvZRGE-bMtIlRXjsUW2BDyw9Pw&s';
  static Size screenSize(context) => MediaQuery.of(context).size;

  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<Map<String, String>> items = [
    {'title':'nigga'},
    {'title':'bitch'},
    {'title':'asshole'},
  ];

  static const List<Map<String, String>> numberItems = [
    {'title':'1'},
    {'title':'2'},
    {'title':'3'},
    {'title':'4'},
    {'title':'5'},
    {'title':'6'},
    {'title':'7'},
    {'title':'8'},
    {'title':'9'},
    {'title':'10'},
  ];


  //* caches
  static bool isAuthenticated = false;
  static bool isRepresentativeAuthenticated = false;
  static bool isGuest = true;
  static String locale = 'EN';

  static String token = '';
}