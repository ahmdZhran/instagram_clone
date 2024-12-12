import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';
import '../cubits/comment_cubit/comment_cubit.dart';
import 'comments_bottom_sheet_widget.dart';

class AddCommentBlocBuilderWidget extends StatelessWidget {
  const AddCommentBlocBuilderWidget({
    super.key,
    required UserProfileEntity? userProfile,
    required this.commentController,
    required CommentCubit commentCubit,
    required this.widget,
  })  : _userProfile = userProfile,
        _commentCubit = commentCubit;

  final UserProfileEntity? _userProfile;
  final TextEditingController commentController;
  final CommentCubit _commentCubit;
  final CommentsBottomSheetWidget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: _userProfile?.profileImageUrl != null
                ? CachedNetworkImageProvider(
                    _userProfile!.profileImageUrl,
                  )
                : const AssetImage(
                    'assets/images/place_holder.png',
                  ) as ImageProvider,
          ),
          const Gap(5),
          Expanded(
            child: CustomTextFormField(
              controller: commentController,
              hintText: context.translate(AppStrings.addYourComment),
            ),
          ),
          const Gap(8),
          BlocBuilder<CommentCubit, CommentState>(
            bloc: _commentCubit,
            builder: (context, state) {
              final isLoading = state is AddCommentLoading;
              return IconButton(
                icon: isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      )
                    : const Icon(
                        Icons.send,
                        color: AppColors.primaryColor,
                      ),
                onPressed: () async {
                  if (commentController.text.trim().isEmpty) return;
                  String commentId =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  _commentCubit.addComment(
                    widget.postId,
                    CommentEntity(
                      commentId: commentId,
                      profilePic: _userProfile!.profileImageUrl,
                      username: _userProfile.username,
                      commentText: commentController.text.trim(),
                      dateOfComment: DateTime.now(),
                      uid: _userProfile.uid,
                    ),
                  );
                  commentController.clear();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
