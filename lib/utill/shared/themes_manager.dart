import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme(){
  return ThemeData(
    scaffoldBackgroundColor: ColorsManager.WHITE,
    textTheme: TextTheme(labelLarge: TextStyle(fontSize: AppSizesDouble.s18)),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ColorsManager.BLACK),
    ),

  );
}