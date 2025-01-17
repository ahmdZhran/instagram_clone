part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomePostsLoading extends HomeState {}

final class HomePostsSuccess extends HomeState {
  final List<PostModel>? posts;

  HomePostsSuccess([this.posts]);
}

final class HomePostsFailure extends HomeState {
  final String errMessage;

  HomePostsFailure({required this.errMessage});
}

final class DeleteUserPostLoading extends HomeState {}

final class DeleteUserPostSuccess extends HomeState {}

final class DeleteUserPostFailure extends HomeState {
  final String errMessage;

  DeleteUserPostFailure({required this.errMessage});

}
