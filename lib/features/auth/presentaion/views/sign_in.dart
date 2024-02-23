import 'package:flutter/material.dart';
import 'package:instagram_clone/core/functions/navigator_methods.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_form_sign_in.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/is_have_an_account_widget.dart';
import '../../../../core/widgets/custom_head_text_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 150),
              CustomHeadText(
                  text: AppStrings.headInstagramTitle,
                  style:
                      CustomTextStyles.pacifico50Style.copyWith(fontSize: 40)),
              const SizedBox(height: 30),
              const CustomFormSignIn(),
              const SizedBox(height: 40),
              IsHaveAnAccountWidget(
                titleOfTextOne: AppStrings.dontHaveAnAccount,
                titleOfTextTwo: AppStrings.signUp,
                onTap: () {
                  customNavigator(context, '/signUpView');
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
