import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    extensions: ThemeExtension<dynamic>[],
    brightness: Brightness.light,
    primaryColor: AppColors.lightModeColor,
    scaffoldBackgroundColor: AppColors.lightModeColor,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightModeColor,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Pacifico',
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Pacifico',
      ),
    ),
    fontFamily: 'Pacifico',
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightModeColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkThemColor,
    scaffoldBackgroundColor: AppColors.darkThemColor,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkThemColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: AppColors.lightModeColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Pacifico',
      ),
    ),
    fontFamily: 'Pacifico',
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Pacifico',
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkThemColor,
    ),
  );
}
