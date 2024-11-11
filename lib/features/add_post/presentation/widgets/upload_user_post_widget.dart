import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';

class UploadUserPostWidget extends StatelessWidget {
  const UploadUserPostWidget({
    super.key,
    required this.image,
    required this.description,
    required this.onPost,
  });

  final Uint8List image;
  final String description;
  final VoidCallback onPost;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPost,
      child: Text(
        context.translate(AppStrings.post),
        style: CustomTextStyle.pacifico14.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
  
}
