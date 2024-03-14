import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utls/spacer.dart';
import '../../../../../core/utls/text_styles.dart';
import '../../../../../core/utls/app_assets.dart';

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
          horizontalSpacer(4),
          Text(
            '245',
            style: CustomTextStyles.normalTextStyle,
          ),
          horizontalSpacer(10),
          SvgPicture.asset(
            Assets.commentIcon,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          horizontalSpacer(6),
          Text(
            '245',
            style: CustomTextStyles.normalTextStyle,
          ),
          horizontalSpacer(8),
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
