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

final class AddCommentLoading extends HomeState {}

final class AddCommentSuccess extends HomeState {}

final class AddCommentFailure extends HomeState {
  final String errMessage;

  AddCommentFailure({required this.errMessage});
}
