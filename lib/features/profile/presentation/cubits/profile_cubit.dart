import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/features/profile/profile_di.dart';

import '../../../../core/theme/app_them.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.sharedPrefHelper}) : super(ProfileInitial());

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

  static const String _tag = "profile_instance";
  static ProfileCubit getInstance() {
    final isRegister = profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (!isRegister) {
      profileDI.registerSingleton<ProfileCubit>(
        ProfileCubit(sharedPrefHelper: profileDI()),
        instanceName: _tag,
      );
    }
    return profileDI.get<ProfileCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (isRegister) {
      final cubit = profileDI<ProfileCubit>(instanceName: _tag);
      await cubit.close();
      profileDI.unregister<ProfileCubit>(instanceName: _tag);
    }
  }
}