import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/router/routes.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/pick_image_post_widget.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        actions: [
          IconButton(
            icon: Icon(
              context.isEnglish ? Iconsax.arrow_right_1 : Iconsax.arrow_left_1,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              context.pushNamed(Routes.addDescriptionToPost);
            },
          )
        ],
      ),
      body: const PickImagePostWidget(
        selectedMedias: [],
      ),
    );
  }
}
