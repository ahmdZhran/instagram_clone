import 'package:flutter/material.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../data/models/media_model.dart';
import '../widgets/upload_user_post_widget.dart';

class AddDescriptionAndUploadPostScreen extends StatelessWidget {
  final List<MediaModel>? selectedMedias;

  const AddDescriptionAndUploadPostScreen({
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
        actions:  [
          UploadUserPostWidget(image: ,description: ,),
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

