import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/features/auth/widgets/auth_text_styles.dart';
import '../../../core/helper/extensions.dart';
import '../presentation/manager/auth_cubit.dart';
import '../../../core/utils/app_colors.dart';
import 'padding_wrapper_widget.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/is_have_an_account_widget.dart';
import 'pick_profile_image.dart';

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
        final auth = AuthCubit.getInstance();
        return Form(
          key: auth.signUpKey,
          child: PaddingWrapperWidget(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    auth.selectedImageProfile();
                  },
                  child: PickProfileImage(auth: auth),
                ),
                const CustomTextFormField(
                  hintText: AppStrings.username,
                  fieldName: AppStrings.username,
                ),
                const CustomTextFormField(
                  fieldName: AppStrings.name,
                  hintText: AppStrings.name,
                ),
                const CustomTextFormField(
                  fieldName: AppStrings.bio,
                  hintText: AppStrings.bio,
                ),
                const CustomTextFormField(
                  hintText: AppStrings.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  fieldName: AppStrings.emailAddress,
                ),
                CustomTextFormField(
                  obscureText: auth.obscuredPasswordText,
                  suffixIcon: IconButton(
                    onPressed: auth.obscuredPassword,
                    icon: Icon(
                      auth.obscuredPasswordText
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
                      if (auth.signUpKey.currentState!.validate()) {}
                    },
                    childOfCustomButton: const SignUpTextStyle()),
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
