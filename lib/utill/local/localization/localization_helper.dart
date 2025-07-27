import 'dart:developer';

import 'package:ameen/utill/local/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localization.dart';

const String LANGUAGECODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  await CacheHelper.saveData(key: LANGUAGECODE, value: languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode;
  languageCode = await CacheHelper.getData(key: LANGUAGECODE)??ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case ARABIC:
      return Locale(ARABIC, "SA");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String getTranslated(String key) {
  return AppLocalizations.translate(key);
}