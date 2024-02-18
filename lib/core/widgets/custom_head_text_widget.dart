import 'package:flutter/material.dart';

import '../utls/text_styles.dart';

class CusotmHeadTextWidget extends StatelessWidget {
  const CusotmHeadTextWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomTextStyles.pacifico50Style,
    );
  }
}
