import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

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
              style: CustomTextStyle.pacifico14,
            ),
            TextSpan(
              text: titleOfTextTwo,
              style: CustomTextStyle.pacifico16
                  .copyWith(color: AppColors.blueColor),
            ),
          ],
        ),
      ),
    );
  }
}
