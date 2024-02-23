import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utls/app_assets.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_button_widget.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_text_form_field.dart';
import 'package:lottie/lottie.dart';

import '../view_model/auth_cubit/auth_cubit.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is EmailResetPasswordSuccess) {
                  print('Go to your inbox to can recive it');
                } else {
                  print('somthign went wrogn try again please');
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 300),
                      const Text(
                        AppStrings.resetPassword,
                        style: CustomTextStyles.pacifico50Style,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.pleaseenterYourEmail,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      const CustomTextFormField(
                          hintText: AppStrings.emailAddress),
                      const SizedBox(height: 50),
                      CustomButton(
                        onPressed: () {},
                        color: AppColors.kBlueColor,
                        childOfCustomButton: state is EmailResetPasswordLoading
                            ? LottieBuilder.asset(Assets.lottieFilePath)
                            : const Text(
                                AppStrings.sendResetPasswordLink,
                                style: TextStyle(color: AppColors.kWhiteColor),
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
