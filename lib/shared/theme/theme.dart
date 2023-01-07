import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: mainColor,
  buttonTheme: const ButtonThemeData(
    buttonColor: mainColor,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xfffdfbda),
    foregroundColor: mainColor,
  ),
);