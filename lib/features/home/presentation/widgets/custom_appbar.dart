import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/text_styles.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.headInstagramTitle,
          style: CustomTextStyles.pacifico50Style.copyWith(fontSize: 20),
        ),
        SvgPicture.asset(
          Assets.chatIcon,
          colorFilter:
              const ColorFilter.mode(AppColors.kWhiteColor, BlendMode.srcIn),
        )
      ],
    );
  }
}
