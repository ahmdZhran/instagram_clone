import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/utils_messages.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/is_have_an_account_widget.dart';
import '../../../../core/widgets/padding_wrapper_widget.dart';
import '../manager/cubit/auth_cubit.dart';
import 'auth_text_styles.dart';
import 'forgot_password_widget.dart';

class CustomFormLogInWidget extends StatefulWidget {
  const CustomFormLogInWidget({super.key});

  @override
  State<CustomFormLogInWidget> createState() => _CustomFormLogInWidgetState();
}

class _CustomFormLogInWidgetState extends State<CustomFormLogInWidget> {
  final loginCubit = AuthCubit.getInstance();
  final GlobalKey<FormState> _logInFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return PaddingWrapperWidget(
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: loginCubit,
        listener: (context, state) {
          if (state is LogInSuccess) {
            FirebaseAuth.instance.currentUser!.emailVerified
                ? context.pushNamedAndRemoveUntil(
                    Routes.mainWidget,
                    predicate: (route) => false,
                  )
                : UtilsMessages.showToastErrorBottom(context,
                    message: AppStrings.pleaseVerifyEmail);

            AuthCubit.deleteInstance();
          } else if (state is LogInFailure) {
            UtilsMessages.showToastErrorBottom(
              context,
              message: state.errMessage,
            );
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              context.showExitConfirmationDialog();
            },
            child: Form(
              key: _logInFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: AppStrings.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    fieldName: AppStrings.emailAddress,
                    controller: loginCubit.emailAddressController,
                  ),
                  const Gap(10),
                  CustomTextFormField(
                    suffixIcon: IconButton(
                      onPressed: loginCubit.obscuredPassword,
                      icon: Icon(
                        loginCubit.obscuredPasswordText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    obscureText: loginCubit.obscuredPasswordText,
                    hintText: AppStrings.password,
                    fieldName: AppStrings.password,
                    controller: loginCubit.passwordController,
                  ),
                  const Gap(20),
                  const ForgotPasswordWidget(),
                  const Gap(20),
                  CustomButton(
                    childOfCustomButton: loginCubit.state is LogInLoading
                        ? LottieBuilder.asset(AppAssets.loadingAnimation)
                        : const LoginTextStyleP16(),
                    onPressed: () {
                      if (_logInFormKey.currentState!.validate()) {
                        loginCubit.logIn();
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  const Gap(30),
                  IsHaveAnAccountWidget(
                    titleOfTextOne: AppStrings.donnHaveAnAccount,
                    titleOfTextTwo: AppStrings.signUp,
                    onTap: () => context.pushNamed(Routes.signUp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
