import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';
import '../cubits/comment_cubit/comment_cubit.dart';
import '../../../../core/models/user_profile_manager.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';
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
  const CommentsBottomSheetWidget({
    super.key,
    required this.scrollController,
    required this.username,
    required this.profileImage,
    required this.postId,
    required this.description,
    required this.deviceToken,
  });

  @override
  State<CommentsBottomSheetWidget> createState() =>
      _CommentsBottomSheetWidgetState();
}

class _CommentsBottomSheetWidgetState extends State<CommentsBottomSheetWidget> {
  UserProfileEntity? _userProfile;
  final TextEditingController commentController = TextEditingController();
  final CommentCubit _commentCubit = CommentCubit.getInstance();
  final List<CommentEntity> _comments = [];
  final List<bool> _isPressed = [];

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _commentCubit.fetchComments(widget.postId);
  }

  void _fetchUserProfile() {
    setState(() {
      _userProfile = UserProfileManager().userProfile;
    });
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
          const Divider(color: AppColors.greyColor, endIndent: 20, indent: 20),
          CommentsListWidget(
              scrollController: widget.scrollController,
              commentCubit: _commentCubit,
              comments: _comments,
              isPressed: _isPressed,
              onLongPress: _showCommentActions),
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
    //! solve this issue 
    // CommentCubit.deleteInstance();
    super.dispose();
  }

  void _showCommentActions(BuildContext context, CommentEntity comment) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20,
          ),
        ),
      ),
      builder: (context) => CommentActionsBottomSheetWidget(
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
      ),
    );
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
