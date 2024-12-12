part of 'comment_cubit.dart';

sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class AddCommentLoading extends CommentState {}

final class AddCommentSuccess extends CommentState {}

final class AddCommentFailure extends CommentState {
  final String errMessage;

  AddCommentFailure({required this.errMessage});
}
