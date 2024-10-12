import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';

class ColorsExtension extends ThemeExtension<ColorsExtension> {
  final Color mainColor;

  const ColorsExtension({required this.mainColor});

  @override
  ThemeExtension<ColorsExtension> copyWith({Color? mainColor}) {
    return ColorsExtension(
      mainColor: mainColor ?? this.mainColor,
    );
  }

  @override
  ThemeExtension<ColorsExtension> lerp(
      covariant ThemeExtension<ColorsExtension>? other, double t) {
    if (other is! ColorsExtension) {
      return this;
    }
    return ColorsExtension(
      mainColor: mainColor,
    );
  }

  static const ColorsExtension dark = ColorsExtension(
    mainColor: AppColors.lightThemeColor,
  );

  static const ColorsExtension light = ColorsExtension(
    mainColor: AppColors.darkThemColor,
  );
}
