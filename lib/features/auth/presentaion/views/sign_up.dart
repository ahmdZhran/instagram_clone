import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import '../../../../core/widgets/custom_head_text_widget.dart';

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
              CustomTextForm()
            ],
          ),
        )
      ],
    ));
  }
}

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(cursorColor: AppColors.kBlueColor),
        ],
      ),
    );
  }
}
