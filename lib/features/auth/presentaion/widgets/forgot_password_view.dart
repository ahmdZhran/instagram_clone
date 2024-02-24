import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_snakbar_widget.dart';
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
                    AppStrings.pleaseenterYourEmail,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is EmailResetPasswordSuccess) {
                        showConfirmingMessage(
                            context, AppStrings.passwordResetEmailSent);
                      } else if (state is EmailResetPasswordFailer) {
                        showErrorMessage(context, state);
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

  void showErrorMessage(BuildContext context, EmailResetPasswordFailer state) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error),
          const SizedBox(width: 10),
          Text(state.errMessage, style: CustomTextStyles.normalTextStyle),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 229, 35, 21),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
