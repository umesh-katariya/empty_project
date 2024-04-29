import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'app_colors.dart';

String robotoFont = 'Roboto';

final appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  colorScheme: const ColorScheme.highContrastLight(
    primary: AppColors.appRed,
    secondary: AppColors.secondary,
    onPrimary: AppColors.primaryColor,
    surface: AppColors.primaryColor,
  ),
  sliderTheme: SliderThemeData(
    overlayShape: SliderComponentShape.noOverlay,
    activeTrackColor: AppColors.backgroundColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor:AppColors.primaryColor)),
  textTheme: const TextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    iconTheme: IconThemeData(color: AppColors.black),
    elevation: 0,
  ),
  dialogTheme: const DialogTheme(
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: Constants.border,
    border: Constants.border,
    disabledBorder: Constants.border,
    errorBorder: Constants.border,
    focusedBorder: Constants.enableBorder,
    focusedErrorBorder: Constants.enableBorder,
    floatingLabelStyle: const TextStyle(color: AppColors.appRed),
    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
    labelStyle: const TextStyle(color: AppColors.textColor30),
  ),
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColors.frequencyBorder),
      overlayColor: MaterialStateProperty.all(AppColors.frequencyBorder)),
  // tabBarTheme: TabBarTheme(
  //   labelPadding: const EdgeInsets.symmetric(vertical: 5),
  //   labelStyle: const TextStyle(fontWeight: FontWeight.bold),
  //   indicatorSize: TabBarIndicatorSize.tab,
  //   unselectedLabelColor: AppColors.blackColor,
  //   indicator: BoxDecoration(
  //       borderRadius: BorderRadius.circular(30), color: AppColors.appRed),
  // ),
  dividerColor: Colors.transparent,
  fontFamily: "Comfortaa",
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
);
