import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_head_text_widget.dart';
import '../widgets/custom_from_sign_up.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 150),
              CusotmHeadTextWidget(),
              SizedBox(height: 50),
              CustomFormSignUp()
            ],
          ),
        )
      ],
    ));
  }
}
