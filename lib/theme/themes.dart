import 'package:doublevpartners/constants/constant.dart';
import 'package:flutter/material.dart';

class Themes {
  MaterialColor cadegranColor = MaterialColor(0xFF2e418e, <int, Color>{
    50: colorPrimary,
    100: colorPrimary,
    200: colorPrimary,
    300: colorPrimary,
    400: colorPrimary,
    500: colorPrimary,
    600: colorPrimary,
    700: colorPrimary,
    800: colorPrimary,
    900: colorPrimary,
  });

  static final light = ThemeData.light().copyWith(
    primaryColor: colorPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: colorPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
