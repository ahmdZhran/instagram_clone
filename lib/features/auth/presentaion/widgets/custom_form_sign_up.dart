import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/navigator_methods.dart';
import '../../../../core/utls/app_strings.dart';
import '../functions/show_error_message.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import '../functions/show_is_confirming_message.dart';
import 'sign_up_form_body.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CreateUserSuccess) {
          showConfirmingMessage(context, AppStrings.weSentVerfyEmail);
          customNavigator(context, '/signInView');
        } else if (state is CreateUserFailer) {
          showErrorMessage(context, state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return SignUpFormBody(authCubit: authCubit);
      },
    );
  }
}
