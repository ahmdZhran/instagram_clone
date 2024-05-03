import 'package:flutter/material.dart';
import '../../../../core/functions/navigator_methods.dart';
import '../../../../core/router/route_constants.dart';
import '../../../../core/utls/spacer_helper.dart';
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
              90.0.getVerticalSpacer(),
              CustomHeadText(
                text: AppStrings.createYourEmail,
                style: CustomTextStyles.pacifico50Style,
              ),
              10.0.getVerticalSpacer(),
              // const AddImageProfileWidget(),
              10.0.getVerticalSpacer(),
              const CustomFormSignUp(),
              10.0.getVerticalSpacer(),
              IsHaveAnAccountWidget(
                titleOfTextOne: AppStrings.alreadyHaveAnAccount,
                titleOfTextTwo: AppStrings.signIn,
                onTap: () {
                  context.customNavigate(RouteConstants.signInRoute);
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
