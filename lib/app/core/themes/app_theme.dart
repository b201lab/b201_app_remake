import 'package:b201_app/app/core/themes/color_theme.dart';
import 'package:b201_app/app/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    backgroundColor: ColorTheme.whiteColor,
    scaffoldBackgroundColor: ColorTheme.whiteColor,
    primaryColor: ColorTheme.redColor,
    textTheme: AppText.textTheme,
    colorScheme: const ColorScheme.light(
      primary: ColorTheme.redColor,
      secondary: ColorTheme.redColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: ColorTheme.whiteColor,
      foregroundColor: ColorTheme.blackColor,
    ),
  );
}
