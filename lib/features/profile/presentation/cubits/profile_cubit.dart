import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/core/helper/shared_pref_keys.dart';
import 'package:instagram_clone/features/profile/profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.sharedPrefHelper}) : super(ProfileInitial());

  bool isDark = true;
  final SharedPrefHelper sharedPrefHelper;

  void changeLanguage(String languageCode) async {
    await sharedPrefHelper.saveData(
        key: SharedPrefKeys.languageKey, value: languageCode);
    emit(ProfileLanguageChanged(locale: Locale(languageCode)));
  }

  void loadLanguage() async {
    final String? languageCode = sharedPrefHelper.getData(key: SharedPrefKeys.languageKey);
    if (languageCode != null) {
      emit(ProfileLanguageChanged(locale: Locale(languageCode)));
    } else {
      emit(ProfileLanguageChanged(locale: const Locale('en')));
    }
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
