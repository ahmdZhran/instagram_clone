import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/auth_text_styles.dart';

import '../../../../core/widgets/padding_wrapper_widget.dart';
import '../widgets/custom_form_sign_up.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: PaddingTopWrapperWidget(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SignUpHeadTitleText(),
              ),
              Gap(30),
              CustomFormSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
