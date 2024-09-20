import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/features/auth/widgets/custom_form_login_widget.dart';
import '../../widgets/login_screen_styles.dart';

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
              child: HeadInstagramTitle(),
            ),
            Gap(20),
            CustomFormLogInWidget(),
          ],
        ),
      ),
    );
  }
}
