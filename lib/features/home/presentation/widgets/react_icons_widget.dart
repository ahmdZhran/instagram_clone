import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/auth_manager.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import '../../../../core/theme/app_them.dart';
import '../cubits/home_cubit/home_cubit.dart';
import 'comments_bottom_sheet_widget.dart';

class ReactIconsWidget extends StatefulWidget {
  final String postId;
  final String username;
  final String profileImage;
  final String description;
  final String deviceToken;
  const ReactIconsWidget({
    super.key,
    required this.postId,
    required this.username,
    required this.profileImage,
    required this.description,
    required this.deviceToken,
  });

  @override
  State<ReactIconsWidget> createState() => _ReactIconsWidgetState();
}

class _ReactIconsWidgetState extends State<ReactIconsWidget> {
  final HomeCubit _homeCubit = HomeCubit.getInstance();
  final currentUserId = AuthManager().userId!;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      builder: (context, state) {
        if (state is HomePostsSuccess) {
          final postsMap = {for (var post in state.posts!) post.id: post};
          final post = postsMap[widget.postId];
          final isLiked = post?.likes.contains(currentUserId) ?? false;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _homeCubit.toggleLikedPost(widget.postId, currentUserId);
                  },
                  child: isLiked
                      ? const ThemedSvgIcon(
                          assetName: AppAssets.heartActiveIcon,
                          colorFilter: ColorFilter.mode(
                            AppColors.redColor,
                            BlendMode.srcIn,
                          ),
                        )
                      : const ThemedSvgIcon(
                          assetName: AppAssets.heartIcon,
                        ),
                ),
                const Gap(6),
                Text((post?.likes.length ?? 0).toString()),
                const Gap(10),
                InkWell(
                  onTap: () => _showCommentsBottomSheet(context),
                  child: const ThemedSvgIcon(
                    assetName: AppAssets.commentIcon,
                  ),
                ),
                const Gap(15),
                const ThemedSvgIcon(
                  assetName: AppAssets.shareIcon,
                ),
                const Gap(6),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return CommentsBottomSheetWidget(
                description: widget.description,
                profileImage: widget.profileImage,
                scrollController: scrollController,
                username: widget.username,
                postId: widget.postId,
                deviceToken: widget.deviceToken,
                uid: AuthManager().userId!,
              );
            },
          ),
        );
      },
    );
  }
}
