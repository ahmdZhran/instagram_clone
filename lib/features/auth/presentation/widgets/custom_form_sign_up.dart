import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/helper/extensions.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/utils_messages.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/is_have_an_account_widget.dart';
import '../../../../core/widgets/padding_wrapper_widget.dart';
import '../manager/cubit/auth_cubit.dart';
import 'auth_text_styles.dart';

class CustomFormSignUp extends StatefulWidget {
  const CustomFormSignUp({super.key});

  @override
  State<CustomFormSignUp> createState() => _CustomFormSignUpState();
}

class _CustomFormSignUpState extends State<CustomFormSignUp> {
  final signUpCubit = AuthCubit.getInstance();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: signUpCubit,
      listener: (context, state) {
        if (state is CreateUserSuccess) {
          UtilsMessages.showConfirmingMessage(
              context, AppStrings.weSentVerifyEmail);
          AuthCubit.deleteInstance();
          context.pushReplacementNamed(Routes.logIn);
        } else if (state is CreateUserFailure) {
          UtilsMessages.showToastErrorBottom(
              message: state.errMessage, context);
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            _showExitConfirmationDialog(context);
          },
          child: Form(
            key: _signUpFormKey,
            child: PaddingWrapperWidget(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      signUpCubit.selectedImageProfile();
                    },
                    child: Column(
                      children: [
                        signUpCubit.profileImage != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    MemoryImage(signUpCubit.profileImage!),
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
                    controller: signUpCubit.usernameController,
                    hintText: AppStrings.username,
                    fieldName: AppStrings.username,
                  ),
                  CustomTextFormField(
                    controller: signUpCubit.nameController,
                    fieldName: AppStrings.name,
                    hintText: AppStrings.name,
                  ),
                  CustomTextFormField(
                    controller: signUpCubit.bioController,
                    fieldName: AppStrings.bio,
                    hintText: AppStrings.bio,
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    fieldName: AppStrings.emailAddress,
                    controller: signUpCubit.emailAddressController,
                  ),
                  CustomTextFormField(
                    obscureText: signUpCubit.obscuredPasswordText,
                    suffixIcon: IconButton(
                      onPressed: signUpCubit.obscuredPassword,
                      icon: Icon(
                        signUpCubit.obscuredPasswordText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    hintText: AppStrings.password,
                    fieldName: AppStrings.password,
                    controller: signUpCubit.passwordController,
                  ),
                  const Gap(20),
                  CustomButton(
                      color: AppColors.primaryColor,
                      onPressed: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          if (signUpCubit.profileImage != null) {
                            signUpCubit.createUserWithEmailAndPassword();
                          } else {
                            UtilsMessages.showToastErrorBottom(
                              context,
                              message: 'Please select an image',
                            );
                          }
                        }
                      },
                      childOfCustomButton:
                          signUpCubit.state is CreateUserLoading
                              ? LottieBuilder.asset(AppAssets.loadingAnimation)
                              : const SignUpTextButtonStyle()),
                  const Gap(20),
                  IsHaveAnAccountWidget(
                    titleOfTextOne: AppStrings.alreadyHaveAnAccount,
                    titleOfTextTwo: AppStrings.logIn,
                    onTap: () => context.pushReplacementNamed(Routes.logIn),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit Confirmation'),
            content:
                const Text('Are you sure you want to back to login screen?'),
            actions: <Widget>[
              TextButton(
                child: const Text(AppStrings.cancel),
                onPressed: () {
                  context.pop();
                },
              ),
              TextButton(
                child: const Text(AppStrings.back),
                onPressed: () {
                  context.pop();
                  context.pop();
                },
              ),
            ],
          );
        });
  }
}
