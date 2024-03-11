import 'package:flutter/material.dart';

import '../utls/app_colors.dart';

class CircularLoadingPlaceholder extends StatelessWidget {
  const CircularLoadingPlaceholder({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.deepGrey,
      ),
    );
  }
}
