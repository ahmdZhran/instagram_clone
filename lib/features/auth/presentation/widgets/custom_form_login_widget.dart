import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/snak_bar_messages.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/is_have_an_account_widget.dart';
import '../manager/auth_cubit.dart';
import 'auth_text_styles.dart';
import 'forgot_password_widget.dart';
import 'padding_wrapper_widget.dart';

class CustomFormLogInWidget extends StatefulWidget {
  const CustomFormLogInWidget({super.key});

  @override
  State<CustomFormLogInWidget> createState() => _CustomFormLogInWidgetState();
}

class _CustomFormLogInWidgetState extends State<CustomFormLogInWidget> {
  @override
  Widget build(BuildContext context) {
    final loginCubit = AuthCubit.getInstance();
    return PaddingWrapperWidget(
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: loginCubit,
        listener: (context, state) {
          if (state is LogInSuccess) {
            SnackBarMessages.showToastSuccessBottom(
                message: AppStrings.loggedInSuccess);
            context.pushNamedAndRemoveUntil(
              Routes.home,
              predicate: (route) => false,
            );
          } else if (state is LogInFailure) {
            SnackBarMessages.showToastErrorBottom(
              context,
              message: state.errMessage,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: loginCubit.loginFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  onChanged: (email) =>
                      loginCubit.emailAddressController.text = email,
                  hintText: AppStrings.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  fieldName: AppStrings.name,
                ),
                const Gap(10),
                CustomTextFormField(
                  onChanged: (password) =>
                      loginCubit.passwordController.text = password,
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
                ),
                const Gap(20),
                const ForgotPasswordWidget(),
                const Gap(20),
                CustomButton(
                  childOfCustomButton: loginCubit.state is LogInLoading
                      ? LottieBuilder.asset(AppAssets.loadingAnimation)
                      : const LoginTextStyleP16(),
                  onPressed: () {
                    if (loginCubit.loginFormKey.currentState!.validate()) {
                      loginCubit.logIn();
                    }
                  },
                  color: AppColors.blueColor,
                ),
                const Gap(30),
                IsHaveAnAccountWidget(
                  titleOfTextOne: AppStrings.donnHaveAnAccount,
                  titleOfTextTwo: AppStrings.signUp,
                  onTap: () => context.pushReplacementNamed(Routes.signUp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    AuthCubit.deleteInstance();
    super.dispose();
  }
}
