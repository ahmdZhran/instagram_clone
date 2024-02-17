import 'package:flutter/material.dart';

import '../utls/app_strings.dart';
import '../utls/text_styles.dart';

class CusotmHeadTextWidget extends StatelessWidget {
  const CusotmHeadTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.headInstagramTitle,
      style: CustomTextStyles.instagramFontStyle,
    );
  }
}
