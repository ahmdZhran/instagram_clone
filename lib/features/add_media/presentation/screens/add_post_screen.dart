import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/helper/extensions.dart';
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
              context.isEnglish ? Iconsax.arrow_right_1 : Iconsax.arrow_left,
              color: AppColors.primaryColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const PickImagePostWidget(),
    );
  }
}
