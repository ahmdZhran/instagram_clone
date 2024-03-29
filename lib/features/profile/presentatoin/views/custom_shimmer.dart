import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/spacer.dart';
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
                  verticalSpacer(10),
                  const RectangularLoadingPlaceHolder(width: 70),
                ],
              ),
              horizontalSpacer(30),
              Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpacer(30),
              Column(
                children: [
                  const RectangularLoadingPlaceHolder(width: 30),
                  verticalSpacer(10),
                  const RectangularLoadingPlaceHolder(width: 70),
                ],
              ),
            ],
          ),
          verticalSpacer(10),
          const RectangularLoadingPlaceHolder(width: 100),
          verticalSpacer(10),
          const RectangularLoadingPlaceHolder(width: 70),
          verticalSpacer(10),
          const RectangularLoadingPlaceHolder(width: 60),
          verticalSpacer(10),
          const RectangularLoadingPlaceHolder(width: 120),
        ],
      ),
    );
  }
}
