import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/functions/show_is_confirming_message.dart';
import '../functions/show_error_message.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'forgot_password_form_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  const Text(
                    AppStrings.resetPassword,
                    style: CustomTextStyles.pacifico50Style,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    AppStrings.pleaseEnterYourEmail,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is EmailResetPasswordSuccess) {
                        showConfirmingMessage(
                            context, AppStrings.passwordResetEmailSent);
                      } else if (state is EmailResetPasswordFailer) {
                        showErrorMessage(context, state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
                      return ForgotPasswordFormBody(authCubit: authCubit);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
