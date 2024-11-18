import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';

class CustomSliverAppBarWidget extends StatelessWidget {
  const CustomSliverAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      backgroundColor:
          context.isDart ? AppColors.darkThemColor : AppColors.lightThemeColor,
      elevation: 0,
      title: Row(
        children: [
          Text(
            AppStrings.headInstagramTitle,
            style: CustomTextStyle.pacifico25,
          ),
          const Spacer(),
          SvgPicture.asset(
            AppAssets.chatIcon,
            colorFilter: ColorFilter.mode(
              context.color.mainColor,
              BlendMode.srcIn,
            ),
          )
        ],
      ),
    );
  }
}
