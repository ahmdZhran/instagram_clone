import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/functions/navigator_methods.dart';
import '../../../../core/router/route_constants.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/spacer_helper.dart';
import '../../../../core/utls/text_styles.dart';
import '../../../../core/widgets/custom_head_text_widget.dart';
import '../widgets/custom_form_sign_in.dart';
import '../widgets/is_have_an_account_widget.dart';

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
              150.0.getVerticalSpacer(),
              CustomHeadText(
                  text: AppStrings.headInstagramTitle,
                  style: CustomTextStyles.pacifico50Style
                      .copyWith(fontSize: 38.sp)),
              28.0.getVerticalSpacer(),
              const CustomFormSignIn(),
              36.0.getVerticalSpacer(),
              IsHaveAnAccountWidget(
                titleOfTextOne: AppStrings.dontHaveAnAccount,
                titleOfTextTwo: AppStrings.signUp,
                onTap: () {
                  context.customNavigate(RouteConstants.signUpRoute);
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
