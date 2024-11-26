import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_them.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubits/settings/settings_cubit.dart';

class SelectionBlocBuilderThemeAndLanguage extends StatefulWidget {
  const SelectionBlocBuilderThemeAndLanguage({
    super.key,
  });

  @override
  State<SelectionBlocBuilderThemeAndLanguage> createState() =>
      _SelectionBlocBuilderThemeAndLanguageState();
}

class _SelectionBlocBuilderThemeAndLanguageState
    extends State<SelectionBlocBuilderThemeAndLanguage> {
  final settingsCubit = SettingsCubit.getInstance();
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<SettingsCubit, SettingsState>(
                      bloc: settingsCubit,
                      builder: (context, state) {
                        return SwitchListTile(
                          inactiveThumbColor: AppColors.primaryColor,
                          activeColor: AppColors.primaryColor,
                          title: const Text(AppStrings.darkMode),
                          value: settingsCubit.isDark,
                          onChanged: (bool value) {
                            settingsCubit.changeTheme();
                          },
                          secondary: const Icon(Icons.dark_mode),
                        );
                      },
                    ),
                    BlocBuilder<SettingsCubit, SettingsState>(
                      bloc: settingsCubit,
                      builder: (context, state) {
                        return ListTile(
                          leading: const Icon(Icons.language),
                          title: DropdownButton<String>(
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            value: settingsCubit.currentLangCode,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: <String>[
                              AppStrings.englishCode,
                              AppStrings.arabicCode
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value == AppStrings.englishCode
                                    ? AppStrings.english
                                    : AppStrings.arabic),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                settingsCubit.changeLanguage(newValue);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const ThemedSvgIcon(
          assetName: AppAssets.settingsIcon,
        ));
  }
}
