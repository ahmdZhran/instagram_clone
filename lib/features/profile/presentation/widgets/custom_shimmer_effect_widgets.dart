import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_colors.dart';

class CustomGridViewWithShimmerEffectWidget extends StatelessWidget {
  const CustomGridViewWithShimmerEffectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.deepGrey,
          highlightColor: AppColors.greyColor,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    ));
  }
}

class CustomShimmerLoadingWidget extends StatelessWidget {
  const CustomShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.deepGrey,
              highlightColor: AppColors.greyColor,
              child: CircleAvatar(
                radius: 40.r,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.deepGrey,
                    highlightColor: AppColors.greyColor,
                    child: Container(
                      width: double.infinity,
                      height: 20.h,
                      color: AppColors.greyColor,
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColors.deepGrey,
                    highlightColor: AppColors.greyColor,
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
        Shimmer.fromColors(
          baseColor: AppColors.deepGrey,
          highlightColor: AppColors.greyColor,
          child: Container(
            width: 120.w,
            height: 20.h,
            color: AppColors.lightGrey,
          ),
        ),
        const Gap(10),
        Shimmer.fromColors(
          baseColor: AppColors.deepGrey,
          highlightColor: AppColors.greyColor,
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
