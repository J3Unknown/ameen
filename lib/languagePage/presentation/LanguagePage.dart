import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/assets_manager.dart';
import '../../utill/shared/colors_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/icons_manager.dart';
import '../../utill/shared/routes_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class LanguagePage extends StatefulWidget {
  final String? img;
  final List<Widget>? widgets;
  const LanguagePage({Key? key,this.img,this.widgets}) : super(key: key,);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  Widget build(BuildContext context) {

  final screenHeight = AppConstants.screenSize(context).height;
  final screenWidth = AppConstants.screenSize(context).width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [

            ],
          ),
        )
      ),
    );
  }
}
