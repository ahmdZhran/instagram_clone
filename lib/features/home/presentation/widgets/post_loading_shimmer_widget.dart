import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_colors.dart';

class PostsLoadingShimmerWidget extends StatelessWidget {
  const PostsLoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Shimmer.fromColors(
          baseColor: AppColors.greyColor.withOpacity(0.5),
          highlightColor: AppColors.greyColor.withOpacity(0.2),
          child: Container(
            width: double.infinity,
            height: 420.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: AppColors.greyColor,
            ),
          ),
        ),
      ),
    );
  }
}
