import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utls/spacer_helper.dart';

import '../../../../../core/utls/app_assets.dart';
import '../../../../../core/utls/text_styles.dart';

class ReactIconsWidgtes extends StatelessWidget {
  const ReactIconsWidgtes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.heartIcon,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          4.0.getHorizontalSpacer(),
          Text(
            '245',
            style: CustomTextStyles.normalTextStyle,
          ),
          10.0.getHorizontalSpacer(),
          SvgPicture.asset(
            Assets.commentIcon,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          6.0.getHorizontalSpacer(),
          Text(
            '245',
            style: CustomTextStyles.normalTextStyle,
          ),
          8.0.getHorizontalSpacer(),
          SvgPicture.asset(
            Assets.shareIcon,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            Assets.bookmark,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
