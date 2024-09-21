import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

class LoginHeadTitleText extends StatelessWidget {
  const LoginHeadTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.headInstagramTitle,
      style: CustomTextStyle.pacifico40,
    );
  }
}

class LoginTextStyleP16 extends StatelessWidget {
  const LoginTextStyleP16({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.logIn,
      style: CustomTextStyle.pacifico16,
    );
  }
}

class ForgotPasswordTextStyle extends StatelessWidget {
  const ForgotPasswordTextStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.forgotPassword,
      style: CustomTextStyle.pacifico18,
    );
  }
}

class SignUpHeadTitleText extends StatelessWidget {
  const SignUpHeadTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.createYourEmail,
      style: CustomTextStyle.pacifico30,
    );
  }
}
