import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/functions/navigator_methods.dart';
import 'package:instagram_clone/features/auth/presentaion/functions/show_error_message.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'sign_in_form_body.dart';

class CustomFormSignIn extends StatelessWidget {
  const CustomFormSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          customNavigator(context, '/homeView');
        } else if (state is SigninFailure) {
          showErrorMessage(
              context, CreateUserFailer(errMessage: state.errMessage));
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return SignInFormBody(authCubit: authCubit);
      },
    );
  }
}
