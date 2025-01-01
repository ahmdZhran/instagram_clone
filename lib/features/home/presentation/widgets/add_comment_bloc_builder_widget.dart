import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../fcm_notification/notification_helper.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';
import '../cubits/comment_cubit/comment_cubit.dart';
import 'comments_bottom_sheet_widget.dart';

class AddCommentBlocBuilderWidget extends StatefulWidget {
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
  State<AddCommentBlocBuilderWidget> createState() =>
      _AddCommentBlocBuilderWidgetState();
}

class _AddCommentBlocBuilderWidgetState
    extends State<AddCommentBlocBuilderWidget> {
  bool isTextNotEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.commentController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    widget.commentController.removeListener(_updateButtonState);
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      isTextNotEmpty = widget.commentController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: widget._userProfile?.profileImageUrl != null
                ? CachedNetworkImageProvider(
                    widget._userProfile!.profileImageUrl,
                  )
                : const AssetImage(
                    'assets/images/place_holder.png',
                  ) as ImageProvider,
          ),
          const Gap(8),
          Expanded(
            child: CustomTextFormField(
              controller: widget.commentController,
              hintText: context.translate(AppStrings.addYourComment),
            ),
          ),
          BlocBuilder<CommentCubit, CommentState>(
            bloc: widget._commentCubit,
            builder: (context, state) {
              final isLoading = state is AddCommentLoading;
              return IconButton(
                icon: isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      )
                    : Icon(
                        Icons.send,
                        color: isTextNotEmpty
                            ? AppColors.primaryColor
                            : AppColors.moreDarkBlueColor,
                      ),
                onPressed: isTextNotEmpty && !isLoading
                    ? () async {
                        if (widget.commentController.text.trim().isEmpty) {
                          return;
                        }
                        String commentId =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        widget._commentCubit.addComment(
                          widget.widget.postId,
                          CommentEntity(
                            commentId: commentId,
                            profilePic: widget._userProfile!.profileImageUrl,
                            username: widget._userProfile!.username,
                            commentText: widget.commentController.text.trim(),
                            dateOfComment: DateTime.now(),
                            uid: widget._userProfile!.uid,
                          ),
                        );
                        widget.commentController.clear();
                        await NotificationService.sendNotification(
                            'c-a8BXtNS9CxSIAUn5P_8D:APA91bEnwDU48tfu9Pn-794_hkFv5l2I0Eyv6aQsNByeCq2zPIIRfYv4TuSIzAqbtxBLKWaL4lp3NC-NsvsjWcWB4gAgWRWeIaT8GYbxDny6roWaUOGKhgA',
                            'someone add comment',
                            'someone add comment on your post ');
                        print(
                          'notification send successssssssssssssssssss',
                        );
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
