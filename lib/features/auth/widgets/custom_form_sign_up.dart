import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/custom_text_style.dart';
import '../../../core/utils/snak_bar_messages.dart';
import 'package:lottie/lottie.dart';
import '../../../core/helper/extensions.dart';
import '../presentation/manager/auth_cubit.dart';
import '../../../core/utils/app_colors.dart';
import 'padding_wrapper_widget.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/is_have_an_account_widget.dart';

class CustomFormSignUp extends StatefulWidget {
  const CustomFormSignUp({super.key});

  @override
  State<CustomFormSignUp> createState() => _CustomFormSignUpState();
}

class _CustomFormSignUpState extends State<CustomFormSignUp> {
  @override
  void dispose() {
    AuthCubit.deleteInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: AuthCubit.getInstance(),
      builder: (context, state) {
        final authCubit = AuthCubit.getInstance();
        return Form(
          key: authCubit.signUpKey,
          child: PaddingWrapperWidget(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    authCubit.selectedImageProfile();
                  },
                  child: Column(
                    children: [
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
                    if (authCubit.signUpKey.currentState!.validate()) {
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
}
