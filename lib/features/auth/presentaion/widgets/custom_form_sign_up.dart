import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_button_widget.dart';

import '../view_model/auth_cubit.dart';
import 'custom_text_form_field.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
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
                      authCubit.emailAdress = emialAddress;
                    },
                    keyboardType: TextInputType.emailAddress),
                CustomTextFormField(
                  onChanged: (password) {
                    authCubit.password = password;
                  },
                  hintText: AppStrings.password,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  onPressed: () {},
                  text: AppStrings.signUp,
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
