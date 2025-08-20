import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:flutter/material.dart';

import '../../shared/constants_manager.dart';
import '../../shared/strings_manager.dart';
import '../shared_preferences.dart';

class LocaleChanger extends ChangeNotifier{
  static String _language = 'en';

  String get getLanguage => _language;

  void changeLocale(String newLanguage) async{
    _language = newLanguage;
    AppConstants.locale = _language;
    await CacheHelper.saveData(key: KeysManager.locale, value: _language);
    notifyListeners();
    AppLocalizations().changeLanguage(newLanguage);
  }

  Future<void> initializeLocale() async{
    _language = await CacheHelper.getData(key: KeysManager.locale)??'en';
    AppConstants.locale = _language;
    notifyListeners();
    AppLocalizations().changeLanguage(_language);
  }
}