import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(comment.profilePic),
                        ),
                        title: Text(comment.username),
                        subtitle: Text(comment.commentText),
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
              widget: widget),
        ],
      ),
    );
  }
}
