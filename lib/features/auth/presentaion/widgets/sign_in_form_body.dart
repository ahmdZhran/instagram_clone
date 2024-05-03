import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/spacer_helper.dart';
import '../../../../core/utls/text_styles.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_text_form_field.dart';
import 'forgot_passowrd_widget.dart';

class SignInFormBody extends StatelessWidget {
  const SignInFormBody({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authCubit.signInFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            CustomTextFormField(
              onChanged: (emailAddress) {
                authCubit.emailAddressController.text = emailAddress;
              },
              hintText: AppStrings.emailAddress,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              onChanged: (password) {
                authCubit.passwordController.text = password;
              },
              obscureText: authCubit.isObsecurePasswordText,
              hintText: AppStrings.password,
              suffixIcon: IconButton(
                onPressed: () {
                  authCubit.togglePasswordVisibility();
                },
                icon: Icon(authCubit.isObsecurePasswordText == true
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            ),
       context.     verticalSpacer(15),
            const ForgotPasswordWidget(),
         context.   verticalSpacer(35),
            CustomButton(
              onPressed: () {
                if (authCubit.signInFormKey.currentState!.validate()) {
                  authCubit.signInWithEmailAndPassword();
                }
              },
              childOfCustomButton: authCubit.state is SignInLoading
                  ? LottieBuilder.asset(Assets.loadingAnimtation)
                  : Text(
                      AppStrings.signIn,
                      style: CustomTextStyles.normalTextStyle,
                    ),
              color: AppColors.kBlueColor,
            ),
          ],
        ),
      ),
    );
  }
}
