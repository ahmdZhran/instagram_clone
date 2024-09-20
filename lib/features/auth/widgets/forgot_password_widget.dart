import 'package:flutter/material.dart';
import 'login_screen_styles.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Align(
        alignment: Alignment.topRight,
        child: ForgotPasswordTextStyle(),
      ),
    );
  }
}
