part of 'user_posts_cubit.dart';

sealed class UserPostsState {}

final class UserPostsInitial extends UserPostsState {}

final class UserPostsLoading extends UserPostsState {}

final class UserPostsSuccess extends UserPostsState {}

final class UserPostsFailure extends UserPostsState {
  final String? errMessage;

  UserPostsFailure({required this.errMessage});
}
