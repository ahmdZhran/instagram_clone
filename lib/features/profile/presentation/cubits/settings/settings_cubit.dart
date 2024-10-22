import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/shared_pref_helper.dart';
import '../../../../../core/helper/shared_pref_keys.dart';
import '../../../profile_di.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.sharedPrefHelper}) : super(SettingsInitial());

  final SharedPrefHelper sharedPrefHelper;

  bool isDark = true;
  String currentLangCode = 'en';

  void changeLanguage(String languageCode) async {
    currentLangCode = languageCode;
    await sharedPrefHelper.saveData(
        key: SharedPrefKeys.languageKey, value: languageCode);
    emit(LanguageChanged(locale: Locale(languageCode)));
  }

  void loadLanguage() async {
    final String? languageCode =
        sharedPrefHelper.getData(key: SharedPrefKeys.languageKey);
    currentLangCode = languageCode ?? 'en';
    emit(LanguageChanged(locale: Locale(currentLangCode)));
  }

  void changeTheme() async {
    isDark = !isDark;
    emit(ThemeChanged(isDark: isDark));
    await sharedPrefHelper.saveData(
        key: SharedPrefKeys.themeKey, value: isDark);
  }

  void loadTheme() {
    final bool isDarkMode =
        sharedPrefHelper.getData(key: SharedPrefKeys.themeKey) ?? true;
    isDark = isDarkMode;
    emit(ThemeChanged(isDark: isDark));
  }

  static const String _tag = "settings_instance";

  static SettingsCubit getInstance() {
    final isRegistered =
        profileDI.isRegistered<SettingsCubit>(instanceName: _tag);
    if (!isRegistered) {
      profileDI.registerSingleton<SettingsCubit>(
        SettingsCubit(sharedPrefHelper: profileDI()),
        instanceName: _tag,
      );
    }
    return profileDI.get<SettingsCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegistered =
        profileDI.isRegistered<SettingsCubit>(instanceName: _tag);
    if (isRegistered) {
      final cubit = profileDI<SettingsCubit>(instanceName: _tag);
      await cubit.close();
      profileDI.unregister<SettingsCubit>(instanceName: _tag);
    }
  }
}
