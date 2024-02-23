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

final class SignInLoading extends AuthState {}

final class SigninSuccess extends AuthState {}

final class SigninFailure extends AuthState {
  final String errMessage;

  SigninFailure({required this.errMessage});
}

final class EmailResetPasswordLoading extends AuthState {}

final class EmailResetPasswordSuccess extends AuthState {}

final class EmailResetPasswordFailer extends AuthState {
  final String errMessage;

  EmailResetPasswordFailer({required this.errMessage});
}

class ObsecurePasswordTextState extends AuthState {}
