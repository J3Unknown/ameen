import 'package:ameen/utill/local/localization/localization_helper.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/BaseComponent.dart';
import '../../utill/shared/assets_manager.dart';
import '../../utill/shared/colors_manager.dart';
import '../../utill/shared/constants_manager.dart';
import '../../utill/shared/strings_manager.dart';
import '../../utill/shared/values_manager.dart';

class LanguagePage extends StatefulWidget {
  final String? img;
  final List<Widget>? widgets;
  const LanguagePage({super.key,this.img,this.widgets});

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late bool isArabic;

  @override
  void initState() {
    isArabic = AppConstants.isArabic;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  final screenHeight = AppConstants.screenSize(context).height;
  final screenWidth = AppConstants.screenSize(context).width;
    return Scaffold(
      backgroundColor: ColorsManager.GREY1,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(AppPaddings.p20),
                child: SizedBox(
                  height: screenWidth,
                  child: Center(child: SvgPicture.asset(AssetsManager.languageImage, fit: BoxFit.contain,))
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
                  height: screenHeight / AppSizesDouble.s2_5,
                  decoration: BoxDecoration(
                    color: ColorsManager.WHITE,
                    borderRadius: BorderRadius.circular(AppSizesDouble.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.translate(StringsManager.chooseYourLanguage), style: Theme.of(context).textTheme.labelLarge),
                      SizedBox(height: AppSizesDouble.s15,),
                      DefaultRadioTile(
                        title: StringsManager.arabic,
                        value: true,
                        groupValue: isArabic,
                        onChanged: (value){
                          setState(() {
                            isArabic = true;
                          });
                          setLocale('ar');
                        },
                        icon: AssetsManager.arabic,
                      ),
                      SizedBox(height: AppSizesDouble.s35,),
                      DefaultRadioTile(
                        title: StringsManager.english,
                        value: false,
                        groupValue: isArabic,
                        onChanged: (value){
                          setState(() {
                            isArabic = false;
                          });
                          setLocale('en');
                        },
                        icon: AssetsManager.english,
                      ),
                      SizedBox(height: AppSizesDouble.s35,),
                      DefaultButton(
                        title: StringsManager.next,
                        onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.login)))
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
