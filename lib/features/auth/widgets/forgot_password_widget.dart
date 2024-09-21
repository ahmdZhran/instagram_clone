import 'package:flutter/material.dart';
import 'auth_text_styles.dart';

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
