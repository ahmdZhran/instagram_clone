import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/core/helper/shared_pref_keys.dart';
import 'package:instagram_clone/features/profile/profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.sharedPrefHelper}) : super(ProfileInitial());

  final SharedPrefHelper sharedPrefHelper;

  bool isDark = true;
  String currentLangCode = 'en';

  void changeLanguage(String languageCode) async {
    currentLangCode = languageCode;
    await sharedPrefHelper.saveData(
        key: SharedPrefKeys.languageKey, value: languageCode);
    emit(ProfileLanguageChanged(locale: Locale(languageCode)));
  }

  void loadLanguage() async {
    final String? languageCode =
        sharedPrefHelper.getData(key: SharedPrefKeys.languageKey);
    currentLangCode = languageCode ?? 'en';
    emit(ProfileLanguageChanged(locale: Locale(currentLangCode)));
  }

  void changeTheme() async {
    isDark = !isDark;
    emit(ProfileThemeChanged(isDark: isDark));
    await sharedPrefHelper.saveData(
        key: SharedPrefKeys.themeKey, value: isDark);
  }

  void loadTheme() {
    final bool isDarkMode =
        sharedPrefHelper.getData(key: SharedPrefKeys.themeKey) ?? true;
    isDark = isDarkMode;
    emit(ProfileThemeChanged(isDark: isDark));
  }

  static const String _tag = "profile_instance";

  static ProfileCubit getInstance() {
    final isRegistered =
        profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (!isRegistered) {
      profileDI.registerSingleton<ProfileCubit>(
        ProfileCubit(sharedPrefHelper: profileDI()),
        instanceName: _tag,
      );
    }
    return profileDI.get<ProfileCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegistered =
        profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (isRegistered) {
      final cubit = profileDI<ProfileCubit>(instanceName: _tag);
      await cubit.close();
      profileDI.unregister<ProfileCubit>(instanceName: _tag);
    }
  }
}
