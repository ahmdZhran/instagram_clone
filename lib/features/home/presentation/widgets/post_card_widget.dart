import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:instagram_clone/features/posts/data/models/post_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_short_messages_for_time_ago.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'circle_profile_image_widget.dart';
import 'react_icons_widget.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('custom', CustomShortMessagesForTimeAgo());
    final timeAgo = timeago.format(post.timestamp, locale: 'custom');

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 430.0.h,
              decoration: _postCardGradient(),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Column(
                children: [
                  _PostHeader(post: post, timeAgo: timeAgo),
                  _PostImage(imageUrl: post.imageUrl),
                  const Gap(10),
                  _PostDescription(
                    description: post.description?.toString(),
                    username: post.username,
                  ),
                  const Gap(10),
                  ReactIconsWidget(
                    deviceToken:
                        post.deviceToken ?? "device token doesn't exist",
                    username: post.username,
                    profileImage: post.userProfileImage,
                    description: post.description ?? "",
                    postId: post.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _postCardGradient() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.greyColor.withValues(alpha: 0.5),
        AppColors.greyColor.withValues(alpha: 0.3),
      ],
    ),
  );
}

class _PostHeader extends StatelessWidget {
  final PostModel post;
  final String timeAgo;

  const _PostHeader({
    required this.post,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      horizontalTitleGap: 10,
      dense: true,
      leading:
          CircleProfileImageWidget(userProfileImage: post.userProfileImage),
      title: Text(post.username, style: CustomTextStyle.pacifico13),
      subtitle: Text(timeAgo),
      trailing: const Icon(Icons.more_horiz),
    );
  }
}

class _PostImage extends StatelessWidget {
  final String imageUrl;

  const _PostImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        width: 300.w,
        height: 300.h,
        child: InstaImageViewer(
          imageUrl: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostDescription extends StatelessWidget {
  final String? description;
  final String username;
  const _PostDescription({this.description, required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: AutoSizeText(
              description != '' ? "$username: $description" : "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
