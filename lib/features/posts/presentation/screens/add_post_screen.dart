import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:instagram_clone/features/posts/presentation/screens/pick_video_reel_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/media_model.dart';
import '../widgets/pick_image_post_widget.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  MediaModel? selectedPostMedia;
  MediaModel? selectedReelMedia;

  @override
  void initState() {
    PostsCubit.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate(
            _currentPage == 0 ? AppStrings.addPost : AppStrings.addReel)),
        actions: [
          if ((_currentPage == 0 && selectedPostMedia != null) ||
              (_currentPage == 1 && selectedReelMedia != null))
            IconButton(
              icon: Icon(
                context.isEnglish
                    ? Iconsax.arrow_right_1
                    : Iconsax.arrow_left_1,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                if (_currentPage == 0 && selectedPostMedia != null) {
                  context.pushNamed(
                    Routes.addDescriptionToPost,
                    arguments: [selectedPostMedia!],
                  );
                } else if (_currentPage == 1 && selectedReelMedia != null) {
                  // Handle reel upload navigation
                  // context.pushNamed(
                  //   Routes.addDescriptionToReel,
                  //   arguments: [selectedReelMedia!],
                  // );
                }
              },
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                context.isEnglish
                    ? Iconsax.arrow_right_1
                    : Iconsax.arrow_left_1,
                color: AppColors.darkBlueColor,
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Text(
                    context.translate(AppStrings.post),
                    style: TextStyle(
                      color: _currentPage == 0
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Text(
                    context.translate(AppStrings.reel),
                    style: TextStyle(
                      color: _currentPage == 1
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          PickImagePostWidget(
            selectedMedias:
                selectedPostMedia != null ? [selectedPostMedia!] : [],
            onSelectionChanged: (selected) {
              setState(() {
                selectedPostMedia = selected.isNotEmpty ? selected.first : null;
              });
            },
          ),
          PickVideoReelWidget(
            selectedMedias:
                selectedReelMedia != null ? [selectedReelMedia!] : [],
            onSelectionChanged: (selected) {
              setState(() {
                selectedReelMedia = selected.isNotEmpty ? selected.first : null;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    PostsCubit.deleteInstance();
    super.dispose();
  }
}

