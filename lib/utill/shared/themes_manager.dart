import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme(){
  return ThemeData(
    scaffoldBackgroundColor: ColorsManager.WHITE,
    textTheme: TextTheme(
      labelLarge: TextStyle(fontSize: AppSizesDouble.s18),
      labelMedium: TextStyle(fontSize: AppSizesDouble.s16),
      titleLarge: TextStyle(fontSize: AppSizesDouble.s14),
      titleMedium: TextStyle(fontSize: AppSizesDouble.s13),
      titleSmall: TextStyle(fontSize: AppSizesDouble.s12),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ColorsManager.BLACK),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: ColorsManager.WHITE,
      color: ColorsManager.PRIMARY_COLOR
    )
  );
}