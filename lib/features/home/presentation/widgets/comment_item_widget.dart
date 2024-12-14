import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final bool isPressed;
  final Function(BuildContext, CommentEntity) onLongPress;

  const CommentItem(
      {super.key,
      required this.comment,
      required this.isPressed,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => onLongPress(context, comment),
      child: Container(
        color: isPressed
            ? AppColors.greyColor.withOpacity(0.3)
            : Colors.transparent,
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(comment.profilePic)),
          title: Text(comment.username),
          subtitle: Row(
            children: [
              Expanded(
                child: ReadMoreText(
                  comment.commentText,
                  trimLines: 2,
                  colorClickableText: AppColors.primaryColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: context.translate(AppStrings.readMore),
                  trimExpandedText: context.translate(AppStrings.showLess),
                ),
              ),
              const Gap(5),
              Text(
                comment.dateOfComment.toReadableDate(),
                style:
                    const TextStyle(color: AppColors.greyColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
