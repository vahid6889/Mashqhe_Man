import 'package:flutter/material.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:mashgh/core/utils/value_manager.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppSize.s14,
        color: ColorManager.darkWhite3,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: AppSize.s8,
        color: ColorManager.darkRed,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppSize.s14,
        color: ColorManager.redAccent,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppSize.s14,
        color: ColorManager.darkGrey,
      ),
      bodySmall: TextStyle(
        color: ColorManager.lightBlack1,
        fontWeight: FontWeight.bold,
        fontSize: AppSize.s14,
      ),
      bodyMedium: TextStyle(
        color: ColorManager.lightBlack1,
        fontWeight: FontWeight.bold,
        fontSize: AppSize.s20,
      ),
      bodyLarge: TextStyle(
        color: ColorManager.lightBlack1,
        fontWeight: FontWeight.bold,
        fontSize: AppSize.s24,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: ColorManager.lightBlue1,
          width: AppSize.s1,
        ),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(AppSize.s20),
        // ),
        // backgroundColor: Colors.transparent.withOpacity(0.1),
      ),
    ),
    unselectedWidgetColor: Colors.black,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blueAccent,
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
    highlightColor: Colors.black54,
    dialogBackgroundColor: const Color(0xFFCBC8E5),
    dividerColor: Colors.black54,
    splashColor: Colors.white,
    focusColor: Colors.black54,
    canvasColor: Colors.black54,
    hintColor: const Color(0xFF011C4B),
    fontFamily: "Vazir",
  );
}
