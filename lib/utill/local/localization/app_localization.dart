import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {

  static final AppLocalizations _instance = AppLocalizations._internal();
  factory AppLocalizations() => _instance;
  AppLocalizations._internal();
  static String translate(String jsonKey) => _instance._translateKey(jsonKey);


  late Map<String, dynamic> _enStrings;
  late Map<String, dynamic> _arStrings;
  String _currentLanguage = 'en';

  Future<void> init() async {
    _enStrings = await _loadJson('en');
    _arStrings = await _loadJson('ar');
  }

  Future<Map<String, dynamic>> _loadJson(String langCode) async {
    String jsonString = await rootBundle.loadString('assets/language/$langCode.json');
    return json.decode(jsonString);
  }


  String _translateKey(String key) {
    final currentMap = _currentLanguage == 'ar' ? _arStrings : _enStrings;
    return currentMap[key] ?? key;
  }

  void changeLanguage(String langCode) {
    if (['en', 'ar'].contains(langCode)) {
      _currentLanguage = langCode;
    }
  }

  String get currentLanguage => _currentLanguage;
}

