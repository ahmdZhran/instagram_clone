import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';

import '../../../../core/theme/app_them.dart';

class ReactIconsWidget extends StatelessWidget {
  const ReactIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          ThemedSvgIcon(
            assetName: AppAssets.heartIcon,
          ),
          Gap(6),
          Text('203'),
          Gap(10),
          ThemedSvgIcon(
            assetName: AppAssets.commentIcon,
          ),
          Gap(6),
          Text('203'),
          Gap(10),
          ThemedSvgIcon(
            assetName: AppAssets.shareIcon,
          ),
          Gap(6),
          Text('1k'),
        ],
      ),
    );
  }
}
