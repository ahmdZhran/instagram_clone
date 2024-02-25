import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/spacer.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/text_styles.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_button_widget.dart';
import 'custom_text_form_field.dart';

class SignUpFormBody extends StatelessWidget {
  const SignUpFormBody({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authCubit.signUpFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            CustomTextFormField(
              onChanged: (firstName) {
                authCubit.firstName = firstName;
              },
              hintText: AppStrings.fristName,
            ),
            CustomTextFormField(
              hintText: AppStrings.lastName,
              onChanged: (lastName) {
                authCubit.lasttName = lastName;
              },
            ),
            CustomTextFormField(
                hintText: AppStrings.emailAddress,
                onChanged: (emialAddress) {
                  authCubit.emailAddress = emialAddress;
                },
                keyboardType: TextInputType.emailAddress),
            CustomTextFormField(
              onChanged: (password) {
                authCubit.password = password;
              },
              hintText: AppStrings.password,
              obscureText: authCubit.isObsecurePasswordText,
              suffixIcon: IconButton(
                  onPressed: () {
                    authCubit.obsecurePasswordText();
                  },
                  icon: Icon(authCubit.isObsecurePasswordText == false
                      ? Icons.visibility
                      : Icons.visibility_off)),
            ),
            verticalSpacer(15),
            CustomButton(
              onPressed: () {
                if (authCubit.signUpFormKey.currentState!.validate()) {
                  authCubit.createUserWithEmailAndPassword();
                }
              },
              childOfCustomButton: authCubit.state is CreateUserLoading
                  ? LottieBuilder.asset(Assets.loadingAnimtation)
                  : Text(AppStrings.signUp,
                      style: CustomTextStyles.normalTextStyle),
              color: AppColors.kBlueColor,
            )
          ],
        ),
      ),
    );
  }
}
