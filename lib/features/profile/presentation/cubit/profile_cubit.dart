import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.sharedPrefHelper) : super(ProfileInitial());

  static const _themeKey = "theme";
  final SharedPrefHelper sharedPrefHelper;

  void toggleTheme(bool isDarkMode) async {
    if (isDarkMode) {
      emit(ProfileThemeChanged(themeData: ThemeData.dark()));
      await sharedPrefHelper.saveData(key: _themeKey, value: true);
    } else {
      emit(ProfileThemeChanged(themeData: ThemeData.light()));
      await sharedPrefHelper.saveData(key: _themeKey, value: false);
    }
  }

  void loadTheme() {
    final bool isDarkMode = SharedPrefHelper().getData(key: _themeKey) ?? false;
    if (isDarkMode) {
      emit(ProfileThemeChanged(themeData: ThemeData.dark()));
    } else {
      emit(ProfileThemeChanged(themeData: ThemeData.light()));
    }
  }
}
