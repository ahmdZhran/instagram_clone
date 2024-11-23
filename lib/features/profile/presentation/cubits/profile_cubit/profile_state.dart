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

class ProfilePostsLoading extends ProfileState {}

class ProfilePostsSuccess extends ProfileState {}

class ProfilePostsFailure extends ProfileState {
  final String errMessage;
  ProfilePostsFailure({required this.errMessage});
}
