import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/snak_bar_messages.dart';
import 'package:instagram_clone/core/widgets/custom_button_widget.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';
import 'package:instagram_clone/features/auth/presentation/widgets/padding_wrapper_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../manager/auth_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = AuthCubit.getInstance();
    return Scaffold(
      body: SafeArea(
        child: PaddingWrapperWidget(
          child: Column(
            children: [
              const Gap(150),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppStrings.resetPassword,
                  style: CustomTextStyle.pacifico40,
                ),
              ),
              const Gap(30),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: resetPasswordCubit,
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    SnackBarMessages.showConfirmingMessage(
                        context, AppStrings.passwordResetEmailSent);
                  } else if (state is ResetPasswordFailure) {
                    SnackBarMessages.showToastErrorBottom(
                      context,
                      message: state.errMessage,
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Form(
                        key: resetPasswordCubit.resetPasswordKey,
                        child: CustomTextFormField(
                          hintText: AppStrings.resetPassword,
                          onChanged: (email) => resetPasswordCubit
                              .passwordController.text = email,
                        ),
                      ),
                      const Gap(30),
                      CustomButton(
                        childOfCustomButton: state is ResetPasswordLoading
                            ? LottieBuilder.asset(AppAssets.loadingAnimation)
                            : Text(
                                AppStrings.resetItNow,
                                style: CustomTextStyle.pacifico14,
                              ),
                        color: AppColors.blueColor,
                        onPressed: () {
                          if (resetPasswordCubit.resetPasswordKey.currentState!
                              .validate()) {
                            resetPasswordCubit.resetPassword();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    AuthCubit.deleteInstance();
    super.dispose();
  }
}
