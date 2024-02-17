import 'package:flutter/material.dart';
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
            ],
          ),
        )
      ],
    ));
  }
}
