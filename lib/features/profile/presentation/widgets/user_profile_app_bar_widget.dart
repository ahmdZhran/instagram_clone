import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';

class UserProfileAppBarWidget extends StatelessWidget {
  const UserProfileAppBarWidget({super.key});

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
            onTap: () {},
            child: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
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
