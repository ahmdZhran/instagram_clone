import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

class UserProfileCountsInfoWidget extends StatelessWidget {
  const UserProfileCountsInfoWidget(
      {super.key, required this.count, required this.title, this.onTap});
  final String count;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(count, style: CustomTextStyle.pacifico20),
            Text(title,
                style: CustomTextStyle.pacifico18
                    .copyWith(color: AppColors.whiteColor)),
          ],
        ),
      ),
    );
  }
}
