import 'package:flutter/material.dart';

class LocaleModel extends ChangeNotifier {
  Locale? _locale = const Locale('ca', 'CA'); //TODO set default locale by user config

  Locale? get locale => _locale;

  void set(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
  
}