import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/functions/navigator_methods.dart';
import 'package:instagram_clone/core/utls/app_assets.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_button_widget.dart';
import 'package:lottie/lottie.dart';

import '../functions/show_message.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_snakbar_widget.dart';
import 'custom_text_form_field.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CreateUserSuccess) {
          showingConfirmingMessage(context);
          customNavigator(context, '/signInView');
        } else if (state is CreateUserFailer) {
          showMessage(context, state);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
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
                    print(password);
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
                const SizedBox(height: 15),
                CustomButton(
                  onPressed: () {
                    if (authCubit.signUpFormKey.currentState!.validate() ==
                        true) {
                      authCubit.createUserWithEmailAndPassword();
                    }
                  },
                  childOfCustomButton: state is CreateUserLoading
                      ? LottieBuilder.asset(Assets.lottieFilePath)
                      : const Text(AppStrings.signUp,
                          style: CustomTextStyles.normalTextStyle),
                  color: AppColors.kBlueColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
