import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../data/models/media_model.dart';

class AddDescriptionToPostScreen extends StatelessWidget {
  final List<MediaModel>? selectedMedias;

  const AddDescriptionToPostScreen({
    super.key,
    required this.selectedMedias,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate(AppStrings.newPost),
          style: CustomTextStyle.pacifico13,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              context.translate(AppStrings.post),
              style: CustomTextStyle.pacifico14.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: TextField(
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: context.translate(
                  AppStrings.addDescription,
                ),
              ),
              onChanged: (value) {},
            ),
            leading: Image(
              image: AssetEntityImageProvider(
                selectedMedias![index].assetEntity,
              ),
            ),
          );
        },
      ),
    );
  }
}
