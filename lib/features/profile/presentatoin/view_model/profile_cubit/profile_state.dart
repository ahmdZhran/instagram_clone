part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;

  ProfileSuccess({required this.userModel});
}

class ProfileFailer extends ProfileState {
  final String errMessage;

  ProfileFailer({required this.errMessage});
}
