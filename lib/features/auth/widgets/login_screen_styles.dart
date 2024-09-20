import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

class HeadInstagramTitle extends StatelessWidget {
  const HeadInstagramTitle({super.key});

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
