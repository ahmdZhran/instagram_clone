import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/profile/data/models/user_model.dart';
import '../../data/models/comment_model.dart';
import '../cubits/comment_cubit/comment_cubit.dart';
import '../../../../core/models/user_profile_manager.dart';
import '../../../../core/utils/app_colors.dart';
import 'add_comment_bloc_builder_widget.dart';
import 'comment_action_bottom_sheet_widget.dart';
import 'comment_list_widget.dart';

class CommentsBottomSheetWidget extends StatefulWidget {
  final ScrollController scrollController;
  final String username;
  final String profileImage;
  final String postId;
  final String description;
  final String deviceToken;
  final String uid;
  const CommentsBottomSheetWidget({
    super.key,
    required this.scrollController,
    required this.username,
    required this.profileImage,
    required this.postId,
    required this.description,
    required this.deviceToken,
    required this.uid,
  });

  @override
  State<CommentsBottomSheetWidget> createState() =>
      _CommentsBottomSheetWidgetState();
}

class _CommentsBottomSheetWidgetState extends State<CommentsBottomSheetWidget> {
  UserProfileDataModel? _userProfile;
  final TextEditingController commentController = TextEditingController();
  final CommentCubit _commentCubit = CommentCubit.getInstance();
  final List<CommentModel> _comments = [];
  final List<bool> _isPressed = [];
  @override
  void initState() {
    super.initState();

    _fetchUserProfile();
    _commentCubit.fetchComments(widget.postId);
  }

  void _fetchUserProfile() {
    _userProfile = UserProfileManager().userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const DragHandle(),
          Header(
              username: widget.username,
              profileImage: widget.profileImage,
              description: widget.description),

          const Divider(color: AppColors.greyColor),
          Flexible(
            child: CommentsListWidget(
              scrollController: widget.scrollController,
              commentCubit: _commentCubit,
              comments: _comments,
              isPressed: _isPressed,
              onLongPress: _showCommentActions,
            ),
          ),
          // CommentsListWidget(
          //   scrollController: widget.scrollController,
          //   commentCubit: _commentCubit,
          //   comments: _comments,
          //   isPressed: _isPressed,
          //   onLongPress: _showCommentActions,
          // ),
          AddCommentBlocBuilderWidget(
            userProfile: _userProfile,
            commentController: commentController,
            commentCubit: _commentCubit,
            widget: widget,
            deviceToken: widget.deviceToken,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    CommentCubit.deleteInstance();
    super.dispose();
  }

  void _showCommentActions(BuildContext context, CommentModel comment) {
    widget.uid == comment.uid
        ? showModalBottomSheet(
            showDragHandle: true,
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            useSafeArea: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.9,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                snap: true,
                builder: (context, scrollController) {
                  return CommentActionsBottomSheetWidget(
                    comment: comment,
                    onDelete: () => _commentCubit.deleteComment(
                      widget.postId,
                      comment.commentId,
                    ),
                    onEdit: (updatedComment) => _commentCubit.editComment(
                      widget.postId,
                      comment.commentId,
                      updatedComment,
                    ),
                  );
                }
                // child: CommentActionsBottomSheetWidget(
                //   comment: comment,
                //   onDelete: () => _commentCubit.deleteComment(
                //     widget.postId,
                //     comment.commentId,
                //   ),
                //   onEdit: (updatedComment) => _commentCubit.editComment(
                //     widget.postId,
                //     comment.commentId,
                //     updatedComment,
                //   ),
                // ),
                ),
          )
        : const SizedBox.shrink();
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String username;
  final String profileImage;
  final String description;

  const Header(
      {super.key,
      required this.username,
      required this.profileImage,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(profileImage)),
      title: Text(username),
      subtitle: Text(description),
    );
  }
}
