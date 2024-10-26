import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/custom_form_login_widget.dart';
import '../widgets/auth_text_styles.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(150),
            Align(
              alignment: Alignment.topCenter,
              child: LoginHeadTitleText(),
            ),
            Gap(30),
            CustomFormLogInWidget(),
          ],
        ),
      ),
    );
  }
}
