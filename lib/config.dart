import 'package:kobin/helper/navigation_class.dart';
import 'package:kobin/plugin_list.dart';
import 'config.dart';
export 'package:flutter/material.dart';
export 'package:kobin/common/common_path_list.dart';
export '../../provider/provider_path_list.dart';
export '../../../widgets/widget_path_list.dart';
export 'package:kobin/screens/screens_path_list.dart';
export 'package:kobin/helper/validation.dart';
export 'dart:async';
export 'dart:math';
export 'package:dropdown_button2/dropdown_button2.dart';

NavigationClass route = NavigationClass();
AppArray appArray = AppArray();
AppCss appCss = AppCss();
AppFonts appFonts = AppFonts();
Validation validation = Validation();
//currency
CurrencyProvider currency(context) {
  final currencyData = Provider.of<CurrencyProvider>(context, listen: false);
  return currencyData;
}

//currency symbol
getSymbol(context) {
  final currencyData =
      Provider.of<CurrencyProvider>(context, listen: true).priceSymbol;
  return currencyData;
}

//theme color
isThemeColorReturn(context) {
  return appColor(context).isDarkMode
      ? appColor(context).appTheme.whiteColor
      : appColor(context).appTheme.primaryColor;
}

//theme color
isThemeColorReturnDark(context) {
  return appColor(context).isDarkMode
      ? appColor(context).appTheme.primaryColor
      : appColor(context).appTheme.whiteColor;
}

//theme button color
isThemeButtonColorReturn(context) {
  return appColor(context).isDarkMode
      ? appColor(context).appTheme.btnPrimaryColor
      : appColor(context).appTheme.primaryColor;
}

//language
String language(context, text) {
  return AppLocalizations.of(context)!.translate(text);
}

//arabic
bool isLanguageRTL(context) {
  return AppLocalizations.of(context)?.locale.languageCode == "ar" ||
      AppLocalizations.of(context)?.locale.languageCode == "fa";
}

//theme
isTheme(context) {
  final theme = Provider.of<ThemeService>(context, listen: false);
  return theme.isDarkMode;
}

//direction
isDirectionRTL(context) {
  final direction = Provider.of<DirectionProvider>(context, listen: false);
  return direction.isDirection;
}
