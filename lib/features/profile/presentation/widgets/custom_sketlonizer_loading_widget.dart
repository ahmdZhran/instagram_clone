import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';

class CustomSketlonizerLoadingWidget extends StatelessWidget {
  const CustomSketlonizerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Skeletonizer(
              enabled: true,
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.lightGrey,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeletonizer(
                    enabled: true,
                    child: Container(
                      width: double.infinity,
                      height: 20.h,
                      color: AppColors.lightGrey,
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                  Skeletonizer(
                    enabled: true,
                    child: Container(
                      width: 150.w,
                      height: 20.h,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(40),
        Skeletonizer(
          enabled: true,
          child: Container(
            width: 120.w,
            height: 20.h,
            color: AppColors.lightGrey,
          ),
        ),
        const Gap(10),
        Skeletonizer(
          enabled: true,
          child: Container(
            width: 100.w,
            height: 20.h,
            color: AppColors.lightGrey,
          ),
        ),
      ],
    );
  }
}
