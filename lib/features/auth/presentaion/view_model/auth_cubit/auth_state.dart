part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class CreateUserLoading extends AuthState {}

class CreateUserSuccess extends AuthState {}

class CreateUserFailer extends AuthState {
  final String errMessage;

  CreateUserFailer({required this.errMessage});
}

class ObsecurePasswordTextState extends AuthState {}
