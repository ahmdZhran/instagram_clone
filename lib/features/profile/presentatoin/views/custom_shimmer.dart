import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/spacer_helper.dart';
import '../../../../core/widgets/rectangular_loading.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.deepGrey,
      highlightColor: AppColors.kWhiteColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const RectangularLoadingPlaceHolder(width: 30),
                  10.0.getVerticalSpacer(),
                  const RectangularLoadingPlaceHolder(width: 70),
                ],
              ),
              30.0.getHorizontalSpacer(),
              Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              30.0.getHorizontalSpacer(),
              Column(
                children: [
                  const RectangularLoadingPlaceHolder(width: 30),
                  10.0.getVerticalSpacer(),
                  const RectangularLoadingPlaceHolder(width: 70),
                ],
              ),
            ],
          ),
          10.0.getVerticalSpacer(),
          const RectangularLoadingPlaceHolder(width: 100),
          10.0.getVerticalSpacer(),
          const RectangularLoadingPlaceHolder(width: 70),
          10.0.getVerticalSpacer(),
          const RectangularLoadingPlaceHolder(width: 60),
          10.0.getVerticalSpacer(),
          const RectangularLoadingPlaceHolder(width: 120),
        ],
      ),
    );
  }
}
