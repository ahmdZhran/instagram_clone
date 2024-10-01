import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'auth_text_styles.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.forgotPassword);
      },
      child: const Align(
        alignment: Alignment.topRight,
        child: ForgotPasswordTextStyle(),
      ),
    );
  }
}
