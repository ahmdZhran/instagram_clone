part of 'posts_cubit.dart';

sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsUploading extends PostsState {}

final class PostsSuccess extends PostsState {
  final List<PostModel>? posts;

  PostsSuccess( [this.posts]);
}

final class PostsFailure extends PostsState {
  final String errMessage;

  PostsFailure({required this.errMessage});
}

