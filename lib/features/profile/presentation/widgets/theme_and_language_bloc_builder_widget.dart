import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubits/profile_cubit/profile_cubit.dart';

class ThemeAndLanguageBlocBuilderWidget extends StatelessWidget {
  const ThemeAndLanguageBlocBuilderWidget({
    super.key,
    required ProfileCubit profileCubit,
  }) : _profileCubit = profileCubit;

  final ProfileCubit _profileCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _profileCubit,
            builder: (context, state) {
              return SwitchListTile(
                inactiveThumbColor: AppColors.primaryColor,
                activeColor: AppColors.primaryColor,
                title: const Text(AppStrings.darkMode),
                value: _profileCubit.isDark,
                onChanged: (bool value) {
                  _profileCubit.changeTheme();
                },
                secondary: const Icon(Icons.dark_mode),
              );
            },
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _profileCubit,
            builder: (context, state) {
              return ListTile(
                leading: const Icon(Icons.language),
                title: DropdownButton<String>(
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  value: _profileCubit.currentLangCode,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: <String>[
                    AppStrings.englishCode,
                    AppStrings.arabicCode
                  ].map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value == AppStrings.englishCode
                              ? AppStrings.english
                              : AppStrings.arabic),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _profileCubit.changeLanguage(newValue);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
