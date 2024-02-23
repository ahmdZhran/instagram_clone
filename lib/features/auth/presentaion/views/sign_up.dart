import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/text_styles.dart';
import '../widgets/is_have_an_account_widget.dart';
import '../../../../core/widgets/custom_head_text_widget.dart';
import '../widgets/custom_form_sign_up.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 150),
              const CustomHeadText(
                text: AppStrings.createYourEmail,
                style: CustomTextStyles.pacifico50Style,
              ),
              const SizedBox(height: 50),
              const CustomFormSignUp(),
              const SizedBox(height: 10),
              IsHaveAnAccountWidget(
                titleOfTextOne: AppStrings.alreadyHaveAnAccount,
                titleOfTextTwo: AppStrings.signIn,
                onTap: () {
                  GoRouter.of(context).push('/signInView');
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
