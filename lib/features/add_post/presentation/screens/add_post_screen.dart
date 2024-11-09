import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/media_model.dart';
import '../widgets/pick_image_post_widget.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<MediaModel> selectedMedias = [];
  bool hasImages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate(AppStrings.addPost)),
        actions: [
          hasImages
              ? IconButton(
                  icon: Icon(
                    context.isEnglish
                        ? Iconsax.arrow_right_1
                        : Iconsax.arrow_left_1,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    context.pushNamed(
                      Routes.addDescriptionToPost,
                      arguments: selectedMedias,
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    context.isEnglish
                        ? Iconsax.arrow_right_1
                        : Iconsax.arrow_left_1,
                    color: AppColors.darkBlueColor,
                  ),
                ),
        ],
      ),
      body: PickImagePostWidget(
        selectedMedias: selectedMedias,
        onSelectionChanged: (selected) {
          setState(() {
            selectedMedias = selected;
            hasImages = selectedMedias.isNotEmpty;
          });
        },
      ),
    );
  }
}
