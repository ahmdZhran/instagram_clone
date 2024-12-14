import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';
import '../cubits/comment_cubit/comment_cubit.dart';
import '../../../../core/models/user_profile_manager.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';
import 'add_comment_bloc_builder_widget.dart';

class CommentsBottomSheetWidget extends StatefulWidget {
  final ScrollController scrollController;
  final String username;
  final String profileImage;
  final String postId;
  final String description;

  const CommentsBottomSheetWidget({
    super.key,
    required this.scrollController,
    required this.username,
    required this.profileImage,
    required this.description,
    required this.postId,
  });

  @override
  State<CommentsBottomSheetWidget> createState() =>
      _CommentsBottomSheetWidgetState();
}

class _CommentsBottomSheetWidgetState extends State<CommentsBottomSheetWidget> {
  UserProfileEntity? _userProfile;
  final TextEditingController commentController = TextEditingController();
  final CommentCubit _commentCubit = CommentCubit.getInstance();
  List<CommentEntity> _comments = [];
  List<bool> _isPressed = [];

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
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.profileImage),
            ),
            title: Text(widget.username),
            subtitle: Text(widget.description),
          ),
          const Divider(
            color: AppColors.greyColor,
            endIndent: 20,
            indent: 20,
          ),
          Expanded(
            child: BlocConsumer<CommentCubit, CommentState>(
              bloc: _commentCubit,
              listener: (context, state) {
                if (state is AddCommentFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${state.errMessage}")),
                  );
                } else if (state is FetchCommentSuccess) {
                  _comments = state.comments;
                  _isPressed = List<bool>.filled(_comments.length, false);
                } else if (state is DeleteCommentSuccess) {
                  _comments.removeWhere(
                      (comment) => comment.commentId == state.commentId);
                  setState(() {});
                } else if (state is DeleteCommentFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${state.errMessage}")),
                  );
                }
              },
              builder: (context, state) {
                if (state is FetchCommentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FetchCommentFailure) {
                  return Center(
                    child: Text(state.errMessage),
                  );
                } else if (_comments.isNotEmpty) {
                  return ListView.builder(
                    controller: widget.scrollController,
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      return InkWell(
                        onLongPress: () {
                          if (FirebaseAuth.instance.currentUser?.uid ==
                              comment.uid) {
                            _showCommentActions(context, comment);
                          }
                        },
                        child: Container(
                          color: _isPressed[index]
                              ? AppColors.greyColor.withOpacity(0.3)
                              : Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  comment.profilePic),
                            ),
                            title: Text(comment.username),
                            subtitle: Text(comment.commentText),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text("No comments yet."));
              },
            ),
          ),
          AddCommentBlocBuilderWidget(
            userProfile: _userProfile,
            commentController: commentController,
            commentCubit: _commentCubit,
            widget: widget,
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

  void _showCommentActions(BuildContext context, CommentEntity comment) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.primaryColor),
              title: Text(context.translate(AppStrings.edit)),
              onTap: () {
                context.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(context.translate(AppStrings.delete)),
              onTap: () async {
                context.pop();
                final confirm = await _confirmDelete(context);
                if (confirm == true) {
                  _commentCubit.deleteComment(widget.postId, comment.commentId);
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cancel, color: AppColors.greyColor),
              title: Text(context.translate(AppStrings.cancel)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            context.translate(AppStrings.deleteComment),
            style: CustomTextStyle.pacifico14,
          ),
          content: Text(context.translate(AppStrings.areYourSureToDeleteCo)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.translate(AppStrings.cancel)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                context.translate(AppStrings.delete),
                style: CustomTextStyle.pacifico14
                    .copyWith(color: AppColors.redColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
