import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../cubits/profile_cubit.dart';

class UserProfileAppBarWidget extends StatelessWidget {
  const UserProfileAppBarWidget({super.key});

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
                        BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: profileCubit,
                          builder: (context, state) {
                            return SwitchListTile(
                              inactiveThumbColor: AppColors.primaryColor,
                              activeColor: AppColors.primaryColor,
                              title: Text(AppStrings.darkMode.tr()),
                              value: profileCubit.isDark,
                              onChanged: (bool value) {
                                profileCubit.changeTheme();
                              },
                              secondary: const Icon(Icons.dark_mode),
                            );
                          },
                        ),
                        // Additional ListTile items...
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
