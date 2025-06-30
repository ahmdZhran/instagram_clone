import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/features/posts/presentation/cubit/posts_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/media_model.dart';
import '../widgets/pick_image_post_widget.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  MediaModel? selectedMedia;
  bool hasImage = false;
  @override
  void initState() {
    PostsCubit.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate(AppStrings.addPost)),
        actions: [
          hasImage
              ? IconButton(
                  icon: Icon(
                    context.isEnglish
                        ? Iconsax.arrow_right_1
                        : Iconsax.arrow_left_1,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    if (selectedMedia != null) {
                      context.pushNamed(
                        Routes.addDescriptionToPost,
                        arguments: [selectedMedia!],
                      );
                    }
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
        selectedMedias: selectedMedia != null ? [selectedMedia!] : [],
        onSelectionChanged: (selected) {
          setState(() {
            selectedMedia = selected.isNotEmpty ? selected.first : null;
            hasImage = selectedMedia != null;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    PostsCubit.deleteInstance();
    super.dispose();
  }
}
