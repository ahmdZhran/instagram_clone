import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_text_form_field.dart';

class ForgotPasswordFormBody extends StatelessWidget {
  const ForgotPasswordFormBody({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: authCubit.resetPasswordKey,
        child: Column(
          children: [
            CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (emailAddress) {
                  authCubit.emailAddressController.text = emailAddress;
                },
                hintText: AppStrings.emailAddress),
            const SizedBox(height: 50),
            CustomButton(
              onPressed: () {
                if (authCubit.resetPasswordKey.currentState!.validate()) {
                  authCubit.resetPasswordWithEmail();
                }
              },
              color: AppColors.kBlueColor,
              childOfCustomButton: authCubit.state is ResetPasswordLoading
                  ? LottieBuilder.asset(Assets.loadingAnimtation)
                  : const Text(
                      AppStrings.sendResetPasswordLink,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                      ),
                    ),
            ),
          ],
        ));
  }
}
