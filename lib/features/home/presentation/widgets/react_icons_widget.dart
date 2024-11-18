import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

class ReactIconsWidget extends StatelessWidget {
  const ReactIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.heartIcon,
            colorFilter: ColorFilter.mode(
              context.isLight
                  ? AppColors.darkThemColor
                  : AppColors.lightThemeColor,
              BlendMode.srcIn,
            ),
          ),
          const Gap(4),
          Text(
            '245',
            style: CustomTextStyle.pacifico14,
          ),
          const Gap(10),
          SvgPicture.asset(
            AppAssets.commentIcon,
            colorFilter: ColorFilter.mode(
              context.isLight
                  ? AppColors.darkThemColor
                  : AppColors.lightThemeColor,
              BlendMode.srcIn,
            ),
          ),
          const Gap(10),
          Text('245', style: CustomTextStyle.pacifico14),
          const Gap(8),
          SvgPicture.asset(
            AppAssets.shareIcon,
            colorFilter: ColorFilter.mode(
              context.isLight
                  ? AppColors.darkThemColor
                  : AppColors.lightThemeColor,
              BlendMode.srcIn,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppAssets.bookmark,
            colorFilter: ColorFilter.mode(
              context.isLight
                  ? AppColors.darkThemColor
                  : AppColors.lightThemeColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
