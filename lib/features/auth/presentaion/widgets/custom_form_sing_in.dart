import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
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
        // TODO: implement listener
        if (state is SigninSuccess) {
          print('success==============================================');
        }
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
                  obscureText: true,
                  hintText: AppStrings.password,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const ForgotPasswordWidget(),
                const SizedBox(height: 40),
                CustomButton(
                  onPressed: () {
                    if (authCubit.signInFormKey.currentState!.validate()) {
                      authCubit.signInWithEmailAndPassword();
                    }
                  },
                  childOfCustomButton: const Text(AppStrings.signIn),
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
