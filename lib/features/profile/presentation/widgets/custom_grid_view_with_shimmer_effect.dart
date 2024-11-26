import 'package:flutter/material.dart';
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
