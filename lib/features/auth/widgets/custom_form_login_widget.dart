import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import 'forgot_password_widget.dart';
import 'login_screen_styles.dart';

class CustomFormLogInWidget extends StatelessWidget {
  const CustomFormLogInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            const CustomTextFormField(
              hintText: AppStrings.emailAddress,
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(10),
            const CustomTextFormField(
              obscureText: true,
              hintText: AppStrings.password,
            ),
            const Gap(20),
            const Gap(35),
            CustomButton(
              childOfCustomButton: const LoginTextStyle(),
              onPressed: () {},
              color: AppColors.blueColor,
            ),
            const Gap(20),
            const ForgotPasswordWidget(),
          ],
        ),
      ),
    );
  }
}
