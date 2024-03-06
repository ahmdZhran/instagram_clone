import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/route_constants.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/functions/navigator_methods.dart';
import '../functions/show_error_message.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'sign_in_form_body.dart';

class CustomFormSignIn extends StatelessWidget {
  const CustomFormSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          FirebaseAuth.instance.currentUser!.emailVerified
              ? customReplacementNavigate(
                  context, RouteConstants.bottomNavBarRoute)
              : showErrorMessage(context, AppStrings.pleaseVefyEmail);
        } else if (state is SignInFailure) {
          showErrorMessage(context, state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return SignInFormBody(authCubit: authCubit);
      },
    );
  }
}
