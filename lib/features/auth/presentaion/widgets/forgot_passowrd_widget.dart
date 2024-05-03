import 'package:flutter/material.dart';

import '../../../../core/functions/navigator_methods.dart';
import '../../../../core/router/route_constants.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/text_styles.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.customNavigate(RouteConstants.forgotPasswordRoute);
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          AppStrings.forgotPassword,
          style: CustomTextStyles.normalTextStyle.copyWith(
            color: AppColors.kBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
