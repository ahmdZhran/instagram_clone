import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

class HeadInstagramTitle extends StatelessWidget {
  const HeadInstagramTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.headInstagramTitle,
      style: CustomTextStyle.pacifico40,
    );
  }
}
