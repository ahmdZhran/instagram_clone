part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String errMessage;

  ProfileFailure({required this.errMessage});
}

class ProfileImageUpdated extends ProfileState {
  final Uint8List image;

  ProfileImageUpdated({required this.image});
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileUpdateFailure extends ProfileState {
  final String errMessage;
  ProfileUpdateFailure({required this.errMessage});
}

class UserPostsLoading extends ProfileState {}

class UserPostsSuccess extends ProfileState {
  final List<UserPostModel> posts;

  UserPostsSuccess({required this.posts});
}

class UserPostsFailure extends ProfileState {
  final String errMessage;
  UserPostsFailure({required this.errMessage});
}
