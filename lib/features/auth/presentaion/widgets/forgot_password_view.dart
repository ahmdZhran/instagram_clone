import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/spacer_helper.dart';
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
                  100.0.getVerticalSpacer(),
                  Text(
                    AppStrings.resetPassword,
                    style: CustomTextStyles.pacifico50Style,
                  ),
                  17.0.getVerticalSpacer(),
                  const Text(
                    AppStrings.pleaseEnterYourEmail,
                    textAlign: TextAlign.center,
                  ),
                  30.0.getVerticalSpacer(),
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
