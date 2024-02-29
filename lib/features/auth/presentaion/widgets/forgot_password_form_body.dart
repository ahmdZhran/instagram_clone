import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import '../../../../core/widgets/custom_button_widget.dart';
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
        key: authCubit.resePassowrdKey,
        child: Column(
          children: [
            CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (emailAddress) {
                  authCubit.emailAddress = emailAddress;
                },
                hintText: AppStrings.emailAddress),
            const SizedBox(height: 50),
            CustomButton(
              onPressed: () {
                if (authCubit.resePassowrdKey.currentState!.validate()) {
                  authCubit.resetPasswordWithEmail();
                }
              },
              color: AppColors.kBlueColor,
              childOfCustomButton: authCubit.state is EmailResetPasswordLoading
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
