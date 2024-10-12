import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../cubits/profile_cubit.dart';

class UserProfileAppBarWidget extends StatefulWidget {
  const UserProfileAppBarWidget({super.key});

  @override
  UserProfileAppBarWidgetState createState() => UserProfileAppBarWidgetState();
}

class UserProfileAppBarWidgetState extends State<UserProfileAppBarWidget> {
  late bool _isDarkMode;
  late String _selectedLanguage;
  final profileCubit = ProfileCubit.getInstance();

  @override
  void initState() {
    super.initState();
    final state = profileCubit.state;
    _isDarkMode = state.themeData.brightness == Brightness.dark;
    _selectedLanguage = state.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      bloc: profileCubit,
      listener: (context, state) {
        _isDarkMode = state.themeData.brightness == Brightness.dark;
        _selectedLanguage = state.locale.languageCode;
        context.setLocale(state.locale);
      },
      child: SliverAppBar(
        centerTitle: false,
        pinned: ModalRoute.of(context)!.isFirst,
        floating: ModalRoute.of(context)!.isFirst,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                '___ahmd.1',
                style: CustomTextStyle.pacifico25,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
                          SwitchListTile(
                            inactiveThumbColor: AppColors.primaryColor,
                            activeColor: AppColors.primaryColor,
                            title: Text(AppStrings.darkMode.tr()),
                            value: _isDarkMode,
                            onChanged: (bool value) {
                              profileCubit.toggleTheme(value);
                            },
                            secondary: const Icon(Icons.dark_mode),
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: DropdownButton<String>(
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              value: _selectedLanguage,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: <String>[
                                AppStrings.englishCode,
                                AppStrings.arabicCode
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value == AppStrings.englishCode
                                      ? AppStrings.english.tr()
                                      : AppStrings.arabic.tr()),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  Locale locale = Locale(newValue);
                                  context.setLocale(locale);
                                  profileCubit.changeLanguage(newValue);
                                }
                              },
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: AppColors.redColor,
                            ),
                            title: Text(AppStrings.logout.tr(),
                                style: CustomTextStyle.pacifico14.copyWith(
                                  color: AppColors.redColor,
                                )),
                            onTap: () {},
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
                colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightModeColor
                        : AppColors.darkThemColor,
                    BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
