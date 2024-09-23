import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/helper/extensions.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/is_have_an_account_widget.dart';
import '../presentation/manager/auth_cubit.dart';
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
  void dispose() {
    AuthCubit.deleteInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaddingWrapperWidget(
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: AuthCubit.getInstance(),
        builder: (context, state) {
          final auth = AuthCubit.getInstance();
          return Form(
            key: auth.loginFormKey,
            child: Column(
              children: [
                const CustomTextFormField(
                  hintText: AppStrings.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  fieldName: AppStrings.name,
                ),
                const Gap(10),
                CustomTextFormField(
                  suffixIcon: IconButton(
                    onPressed: auth.obscuredPassword,
                    icon: Icon(
                      auth.obscuredPasswordText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  obscureText: auth.obscuredPasswordText,
                  hintText: AppStrings.password,
                  fieldName: AppStrings.password,
                ),
                const Gap(20),
                const ForgotPasswordWidget(),
                const Gap(20),
                CustomButton(
                  childOfCustomButton: const LoginTextStyleP16(),
                  onPressed: () {
                    if (auth.loginFormKey.currentState!.validate()) {}
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
}
