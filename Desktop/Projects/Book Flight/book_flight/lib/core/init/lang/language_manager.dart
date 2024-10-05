import 'package:flutter/material.dart';

class LanguageManager {
  static const enLocale = Locale('en', 'US');
  static const trLocale = Locale('tr', 'TR');

  static List<Locale> get supportedLocales => [enLocale, trLocale];

  static Locale? localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
