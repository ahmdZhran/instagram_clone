import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';
import '../cubits/comment_cubit/comment_cubit.dart';
import 'comment_item_widget.dart';

class CommentsListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final CommentCubit commentCubit;
  final List<CommentEntity> comments;
  final List<bool> isPressed;
  final Function(BuildContext, CommentEntity) onLongPress;

  const CommentsListWidget({
    super.key,
    required this.scrollController,
    required this.commentCubit,
    required this.comments,
    required this.isPressed,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<CommentCubit, CommentState>(
        bloc: commentCubit,
        listener: (context, state) {
          if (state is AddCommentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.errMessage}")));
          } else if (state is FetchCommentSuccess) {
            comments.clear();
            comments.addAll(state.comments);
            isPressed.clear();
            isPressed.addAll(List<bool>.filled(comments.length, false));
          } else if (state is DeleteCommentSuccess) {
            comments
                .removeWhere((comment) => comment.commentId == state.commentId);
          } else if (state is EditCommentSuccess) {
            final index = comments
                .indexWhere((comment) => comment.commentId == state.commentId);
            if (index != -1) {
              comments[index] =
                  comments[index].copyWith(commentText: state.updatedComment);
            }
          }
        },
        builder: (context, state) {
          if (state is FetchCommentLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ));
          } else if (state is FetchCommentFailure) {
            return Center(child: Text(state.errMessage));
          } else if (comments.isNotEmpty) {
            return ListView.builder(
              controller: scrollController,
              itemCount: comments.length,
              itemBuilder: (context, index) => CommentItem(
                comment: comments[index],
                isPressed: isPressed[index],
                onLongPress: onLongPress,
              ),
            );
          }
          return Center(
            child: Text(
              context.translate(AppStrings.beTheFirstToComment),
            ),
          );
        },
      ),
    );
  }
}
