import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'colors_extension.dart';
import '../utils/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    extensions: const <ThemeExtension<dynamic>>[ColorsExtension.light],
    brightness: Brightness.light,
    primaryColor: AppColors.lightThemeColor,
    scaffoldBackgroundColor: AppColors.lightThemeColor,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightThemeColor,
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
      backgroundColor: AppColors.lightThemeColor,
    ),
  );

  static final darkTheme = ThemeData(
    extensions: const <ThemeExtension<dynamic>>[ColorsExtension.dark],
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
        color: AppColors.lightThemeColor,
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

class ThemedSvgIcon extends StatelessWidget {
  final String assetName;
  final double size;

  const ThemedSvgIcon({
    super.key,
    required this.assetName,
    this.size = 24.0, 
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor =
        context.isLight ? AppColors.darkThemColor : AppColors.lightThemeColor;

    return SvgPicture.asset(
      assetName,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      width: size,
      height: size,
    );
  }
}
