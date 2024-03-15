part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInfoInitial extends ProfileState {}

class ProfileInfoLoading extends ProfileState {}

class ProfileInfoSuccess extends ProfileState {
  final UserProfile userProfile;

  ProfileInfoSuccess({required this.userProfile});
}

class ProfileInfoFailer extends ProfileState {
  final String errMessage;

  ProfileInfoFailer({required this.errMessage});
}

class UserImageSelectedLoading extends ProfileState {}

class UserImageSelectedSuccess extends ProfileState {}

class UserImageSelectedFailure extends ProfileState {
  final String errMessage;

  UserImageSelectedFailure({required this.errMessage});
}
