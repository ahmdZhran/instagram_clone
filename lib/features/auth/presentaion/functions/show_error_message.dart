import 'package:flutter/material.dart';
import '../../../../core/utls/spacer_helper.dart';
import '../../../../core/utls/text_styles.dart';

void showErrorMessage(BuildContext context, String errMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error),
          10.0.getHorizontalSpacer(),
          Text(errMessage, style: CustomTextStyles.normalTextStyle),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 229, 35, 21),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
