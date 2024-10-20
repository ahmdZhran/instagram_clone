import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubits/settings/settings_cubit.dart';
import 'user_name_widget.dart';

class UserProfileAppBarWidget extends StatelessWidget {
  const UserProfileAppBarWidget({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.getInstance();

    return SliverAppBar(
      centerTitle: false,
      pinned: ModalRoute.of(context)!.isFirst,
      floating: ModalRoute.of(context)!.isFirst,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserNameWidget(uid: uid),
          const Spacer(),
          InkWell(
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
            child: SvgPicture.asset(
              height: 22.h,
              width: 22.w,
              'assets/svg/settings.svg',
              colorFilter:
                  ColorFilter.mode(context.color.mainColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
