import 'package:ameen/Repo/pair_of_id_and_name.dart';
import 'package:flutter/cupertino.dart';

class AppConstants{
  static const String imagePath = 'assets/image/';
  static const String baseUrl = 'https://ameenkw.com/ameen/public/api/';
  static const String baseDeliveryUrl = 'https://ameenkw.com/ameen/public/driver/';
  static const String baseImageUrl = 'https://ameenkw.com/ameen/public/';

  static const String basePlaceholderImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHnKw8zTPIFvZRGE-bMtIlRXjsUW2BDyw9Pw&s';
  static Size screenSize(context) => MediaQuery.of(context).size;

  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).+$');

  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];

  static final List<PairOfIdAndName> numberItems = [
    PairOfIdAndName(1, '1'),
    PairOfIdAndName(2, '2'),
    PairOfIdAndName(3, '3'),
    PairOfIdAndName(4, '4'),
    PairOfIdAndName(5, '5'),
    PairOfIdAndName(6, '6'),
    PairOfIdAndName(7, '7'),
    PairOfIdAndName(8, '8'),
    PairOfIdAndName(9, '9'),
    PairOfIdAndName(10, '10'),
  ];


  //* caches
  static bool isAuthenticated = false;
  static bool isRepresentativeAuthenticated = false;
  static bool isGuest = true;
  static String locale = 'EN';
  static String representativePhone = '';
  static String representativePassword = '';

  static String token = '';
}