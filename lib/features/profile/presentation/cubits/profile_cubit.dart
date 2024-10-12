import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/app_them.dart';
import 'package:instagram_clone/features/profile/profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.sharedPrefHelper})
      : super(ProfileState(
          themeData: AppThemes.darkTheme,
          locale: const Locale(
            AppStrings.englishCode,
          ),
        ));

  static const _themeKey = "theme";
  static const _languageKey = "language";

  final SharedPrefHelper sharedPrefHelper;

  void toggleTheme(bool isDarkMode) async {
    ThemeData newTheme =
        isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
    await sharedPrefHelper.saveData(key: _themeKey, value: isDarkMode);
    emit(state.copyWith(themeData: newTheme));
  }

  void loadTheme() {
    final bool isDarkMode = sharedPrefHelper.getData(key: _themeKey) ?? true;
    ThemeData theme = isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
    emit(state.copyWith(themeData: theme));
  }

  void changeLanguage(String languageCode) async {
    await sharedPrefHelper.saveData(key: _languageKey, value: languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  void loadLanguage() {
    final String? languageCode = sharedPrefHelper.getData(key: _languageKey);
    Locale locale = Locale(languageCode ?? AppStrings.englishCode);
    emit(state.copyWith(locale: locale));
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
