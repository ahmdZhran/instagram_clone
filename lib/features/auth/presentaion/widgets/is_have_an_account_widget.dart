import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';

class IsHaveAnAccountWidget extends StatelessWidget {
  const IsHaveAnAccountWidget(
      {super.key,
      required this.titleOfTextOne,
      required this.titleOfTextTwo,
      this.onTap});
  final String titleOfTextOne;
  final String titleOfTextTwo;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: titleOfTextOne,
              style: CustomTextStyles.normalTextStyle
                  .copyWith(color: AppColors.kGreyColor),
            ),
            TextSpan(
              text: titleOfTextTwo,
              style: CustomTextStyles.normalTextStyle.copyWith(
                  color: AppColors.kBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
