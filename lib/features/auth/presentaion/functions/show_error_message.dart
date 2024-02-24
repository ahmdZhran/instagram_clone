import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';

import '../view_model/auth_cubit/auth_cubit.dart';

void showErrorMessage(BuildContext context, CreateUserFailer state) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        const Icon(Icons.error),
        const SizedBox(width: 10),
        Text(state.errMessage, style: CustomTextStyles.normalTextStyle),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 229, 35, 21),
    behavior: SnackBarBehavior.floating,
  ));
}
