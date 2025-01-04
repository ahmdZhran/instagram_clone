part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomePostsLoading extends HomeState {}

final class HomePostsSuccess extends HomeState {
  final List<PostEntity>? posts;

  HomePostsSuccess([this.posts]);
}

final class HomePostsFailure extends HomeState {
  final String errMessage;

  HomePostsFailure({required this.errMessage});
}


final class CommentInitial extends HomeState {}

final class AddCommentLoading extends HomeState {}

final class AddCommentSuccess extends HomeState {
  final CommentEntity comment;

  AddCommentSuccess({required this.comment});
}

final class AddCommentFailure extends HomeState {
  final String errMessage;

  AddCommentFailure({required this.errMessage});
}

final class FetchCommentLoading extends HomeState {}

final class FetchCommentSuccess extends HomeState {
  final List<CommentEntity> comments;

  FetchCommentSuccess({required this.comments});
}

final class FetchCommentFailure extends HomeState {
  final String errMessage;

  FetchCommentFailure({required this.errMessage});
}

class DeleteCommentLoading extends HomeState {}

class DeleteCommentSuccess extends HomeState {
  final String commentId;

  DeleteCommentSuccess({required this.commentId});
}

class DeleteCommentFailure extends HomeState {
  final String errMessage;

  DeleteCommentFailure({required this.errMessage});
}

class EditCommentLoading extends HomeState {}

class EditCommentSuccess extends HomeState {
  final String commentId;
  final String updatedComment;

  EditCommentSuccess({
    required this.commentId,
    required this.updatedComment,
  });
}

class EditCommentFailure extends HomeState {
  final String errMessage;

  EditCommentFailure({required this.errMessage});
}
