import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../../../core/utils/snak_bar_messages.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/is_have_an_account_widget.dart';
import '../manager/auth_cubit.dart';
import 'padding_wrapper_widget.dart';

class CustomFormSignUp extends StatefulWidget {
  const CustomFormSignUp({super.key});

  @override
  State<CustomFormSignUp> createState() => _CustomFormSignUpState();
}

class _CustomFormSignUpState extends State<CustomFormSignUp> {
  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.getInstance();
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state) {
        if (state is CreateUserSuccess) {
          SnackBarMessages.showConfirmingMessage(
              context, 'User created successfully!');
          context.pushNamedAndRemoveUntil(Routes.home,
              predicate: (route) => false);
        } else if (state is CreateUserFailure) {
          SnackBarMessages.showErrorMessage(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Form(
          key: authCubit.signUpFormKey,
          child: PaddingWrapperWidget(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    authCubit.selectedImageProfile();
                    debugPrint('image seletected successfully ');
                  },
                  child: Column(
                    children: [
                      state is ProfileImageSelected &&
                              authCubit.profileImage != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  MemoryImage(authCubit.profileImage!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              child: Icon(
                                Icons.add_a_photo,
                                size: 60,
                                color: Colors.grey[600],
                              ),
                            ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  onChanged: (username) {
                    authCubit.usernameController.text = username;
                  },
                  hintText: AppStrings.username,
                  fieldName: AppStrings.username,
                ),
                CustomTextFormField(
                  onChanged: (name) {
                    authCubit.nameController.text = name;
                  },
                  fieldName: AppStrings.name,
                  hintText: AppStrings.name,
                ),
                CustomTextFormField(
                  onChanged: (bio) {
                    authCubit.bioController.text = bio;
                  },
                  fieldName: AppStrings.bio,
                  hintText: AppStrings.bio,
                ),
                CustomTextFormField(
                  onChanged: (emailAddress) {
                    authCubit.emailAddressController.text = emailAddress;
                  },
                  hintText: AppStrings.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  fieldName: AppStrings.emailAddress,
                ),
                CustomTextFormField(
                  onChanged: (password) {
                    authCubit.passwordController.text = password;
                  },
                  obscureText: authCubit.obscuredPasswordText,
                  suffixIcon: IconButton(
                    onPressed: authCubit.obscuredPassword,
                    icon: Icon(
                      authCubit.obscuredPasswordText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  hintText: AppStrings.password,
                  fieldName: AppStrings.password,
                ),
                const Gap(20),
                CustomButton(
                  color: AppColors.blueColor,
                  onPressed: () {
                    if (authCubit.signUpFormKey.currentState!.validate()) {
                      if (authCubit.profileImage != null) {
                        authCubit.createUserWithEmailAndPassword();
                      } else {
                        SnackBarMessages.showErrorMessage(
                            context, 'Please select an image');
                      }
                    }
                  },
                  childOfCustomButton: authCubit.state is CreateUserLoading
                      ? LottieBuilder.asset(AppAssets.loadingAnimation)
                      : Text(
                          AppStrings.signUp,
                          style: CustomTextStyle.normalTextStyle,
                        ),
                ),
                const Gap(20),
                IsHaveAnAccountWidget(
                  titleOfTextOne: AppStrings.alreadyHaveAnAccount,
                  titleOfTextTwo: AppStrings.logIn,
                  onTap: () => context.pushReplacementNamed(Routes.logIn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    AuthCubit.deleteInstance();
    super.dispose();
  }
}
