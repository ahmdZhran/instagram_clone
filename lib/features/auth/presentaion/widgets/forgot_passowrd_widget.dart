import 'package:flutter/material.dart';

import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/text_styles.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        AppStrings.forgotPassword,
        style: CustomTextStyles.normalTextStyle.copyWith(
          color: AppColors.kBlueColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
