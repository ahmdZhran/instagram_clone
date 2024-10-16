import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/features/auth/domain/entities/user_data_entity.dart';
import 'package:instagram_clone/features/auth/presentation/manager/cubit/auth_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../cubits/profile_cubit.dart';

class UserProfileAppBarWidget extends StatefulWidget {
  const UserProfileAppBarWidget({super.key});

  @override
  State<UserProfileAppBarWidget> createState() =>
      _UserProfileAppBarWidgetState();
}

class _UserProfileAppBarWidgetState extends State<UserProfileAppBarWidget> {
  final authCubit = AuthCubit.getInstance();

  UserDataEntity? userDataEntity;

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.getInstance();

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
              userDataEntity!.name.toString(),
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
                        BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: profileCubit,
                          builder: (context, state) {
                            return SwitchListTile(
                              inactiveThumbColor: AppColors.primaryColor,
                              activeColor: AppColors.primaryColor,
                              title: const Text(AppStrings.darkMode),
                              value: profileCubit.isDark,
                              onChanged: (bool value) {
                                profileCubit.changeTheme();
                              },
                              secondary: const Icon(Icons.dark_mode),
                            );
                          },
                        ),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: profileCubit,
                          builder: (context, state) {
                            return ListTile(
                              leading: const Icon(Icons.language),
                              title: DropdownButton<String>(
                                underline: Container(
                                  height: 2,
                                  color: Colors.transparent,
                                ),
                                value: profileCubit.currentLangCode,
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
                                    profileCubit.changeLanguage(newValue);
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
