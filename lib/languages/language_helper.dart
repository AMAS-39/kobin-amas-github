import 'package:flutter/material.dart';

class LanguageHelper {
  convertLangNameToLocale(String langNameToConvert) {
    Locale convertedLocale;

    switch (langNameToConvert) {
      case "english":
        convertedLocale = const Locale('en', 'EN');
        break;
      case 'arabic':
        convertedLocale = const Locale('ar', 'AE');
        break;
      case "kurdish":
        convertedLocale = const Locale('fa');
        break;

      default:
        convertedLocale = const Locale('en', 'EN');
    }

    return convertedLocale;
  }

  convertLocaleToLangName(String localeToConvert) {
    String langName;
    print(localeToConvert);
    switch (localeToConvert) {
      case 'en':
        langName = "English";
        break;
      case 'ar':
        langName = "عربي";
        break;
      case 'fa':
        langName = "kurdish";
        break;
      default:
        langName = "English";
    }

    return langName;
  }
}
