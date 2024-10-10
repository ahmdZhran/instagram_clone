import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/core/utils/app_them.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.sharedPrefHelper) : super(ProfileInitial());

  static const _themeKey = "theme";
  final SharedPrefHelper sharedPrefHelper;

  void toggleTheme(bool isDarkMode) async {
    if (isDarkMode) {
      emit(ProfileThemeChanged(themeData: AppThemes.darkTheme));
      await sharedPrefHelper.saveData(key: _themeKey, value: true);
    } else {
      emit(ProfileThemeChanged(themeData: AppThemes.lightTheme));
      await sharedPrefHelper.saveData(key: _themeKey, value: false);
    }
  }

  void loadTheme() {
    final bool isDarkMode = SharedPrefHelper().getData(key: _themeKey) ?? true;
    if (isDarkMode) {
      emit(ProfileThemeChanged(themeData: AppThemes.darkTheme));
    } else {
      emit(ProfileThemeChanged(themeData: AppThemes.lightTheme));
    }
  }
}
