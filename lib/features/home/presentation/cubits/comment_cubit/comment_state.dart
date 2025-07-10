part of 'comment_cubit.dart';

sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class AddCommentLoading extends CommentState {}

final class AddCommentSuccess extends CommentState {
  final CommentModel comment;

  AddCommentSuccess({required this.comment});
}

final class AddCommentFailure extends CommentState {
  final String errMessage;

  AddCommentFailure({required this.errMessage});
}

final class FetchCommentLoading extends CommentState {}

final class FetchCommentSuccess extends CommentState {
  final List<CommentModel> comments;

  FetchCommentSuccess({required this.comments});
}

final class FetchCommentFailure extends CommentState {
  final String errMessage;

  FetchCommentFailure({required this.errMessage});
}

class DeleteCommentLoading extends CommentState {}

class DeleteCommentSuccess extends CommentState {
  final String commentId;

  DeleteCommentSuccess({required this.commentId});
}

class DeleteCommentFailure extends CommentState {
  final String errMessage;

  DeleteCommentFailure({required this.errMessage});
}

class EditCommentLoading extends CommentState {}

class EditCommentSuccess extends CommentState {
  final String commentId;
  final String updatedComment;

  EditCommentSuccess({
    required this.commentId,
    required this.updatedComment,
  });
}

class EditCommentFailure extends CommentState {
  final String errMessage;

  EditCommentFailure({required this.errMessage});
}
