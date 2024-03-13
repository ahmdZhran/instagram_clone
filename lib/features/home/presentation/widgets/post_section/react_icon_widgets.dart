import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utls/spacer.dart';
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
          const Text('245'),
          horizontalSpacer(10),
          SvgPicture.asset(
            Assets.commentIcon,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          horizontalSpacer(6),
          const Text('245'),
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
