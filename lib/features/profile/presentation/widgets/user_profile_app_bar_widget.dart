import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';

class UserProfileAppBarWidget extends StatefulWidget {
  const UserProfileAppBarWidget({super.key});

  @override
  UserProfileAppBarWidgetState createState() => UserProfileAppBarWidgetState();
}

class UserProfileAppBarWidgetState extends State<UserProfileAppBarWidget> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                backgroundColor: AppColors.darkThemColor,
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
                          activeColor: AppColors.primaryColor,
                          title: Text(AppStrings.darkMode.tr()),
                          value: _isDarkMode,
                          onChanged: (bool value) {
                            setState(() {
                              _isDarkMode = value;
                            });
                          },
                          secondary: const Icon(Icons.dark_mode),
                        ),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: DropdownButton<String>(
                            underline: Container(
                              height: 2,
                              width: 10,
                              color: Colors.transparent,
                            ),
                            value: _selectedLanguage,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: <String>[
                              AppStrings.english.tr(),
                              AppStrings.arabic.tr()
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLanguage = newValue!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: Text(AppStrings.logout.tr()),
                          onTap: () {
                            // Handle logout tap
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
                  const ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
