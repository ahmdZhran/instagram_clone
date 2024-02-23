import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/functions/navigator_methods.dart';
import 'package:instagram_clone/core/utls/app_assets.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_snakbar_widget.dart';
import 'package:lottie/lottie.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_button_widget.dart';
import 'custom_text_form_field.dart';
import 'forgot_passowrd_widget.dart';

class CustomFormSignIn extends StatelessWidget {
  const CustomFormSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          showingConfirmingMessage(context);
          customNavigator(context, '/homeView');
        } else if (state is SigninFailure) {}
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signInFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                CustomTextFormField(
                  onChanged: (emailAddress) {
                    authCubit.emailAddress = emailAddress;
                  },
                  hintText: AppStrings.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextFormField(
                  onChanged: (password) {
                    authCubit.password = password;
                  },
                  obscureText: authCubit.isObsecurePasswordText,
                  hintText: AppStrings.password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      authCubit.obsecurePasswordText();
                    },
                    icon: Icon(authCubit.isObsecurePasswordText == true
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                const SizedBox(height: 15),
                const ForgotPasswordWidget(),
                const SizedBox(height: 40),
                CustomButton(
                  onPressed: () {
                    if (authCubit.signInFormKey.currentState!.validate() ==
                        true) {
                      authCubit.signInWithEmailAndPassword();
                    }
                  },
                  childOfCustomButton: state is SignInLoading
                      ? LottieBuilder.asset(Assets.lottieFilePath)
                      : const Text(
                          AppStrings.signIn,
                          style: CustomTextStyles.normalTextStyle,
                        ),
                  color: AppColors.kBlueColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
