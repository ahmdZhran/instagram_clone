import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/spacer.dart';
import '../../../../core/utls/text_styles.dart';
import '../functions/show_error_message.dart';
import '../functions/show_is_confirming_message.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'forgot_password_form_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  context.verticalSpacer(100),
                  Text(
                    AppStrings.resetPassword,
                    style: CustomTextStyles.pacifico50Style,
                  ),
                  context.verticalSpacer(17),
                  const Text(
                    AppStrings.pleaseEnterYourEmail,
                    textAlign: TextAlign.center,
                  ),
                  context.verticalSpacer(30),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is ResetPasswordSuccess) {
                        showConfirmingMessage(
                            context, AppStrings.passwordResetEmailSent);
                      } else if (state is ResetPasswordFailure) {
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
