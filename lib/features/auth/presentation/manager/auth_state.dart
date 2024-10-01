part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class CreateUserLoading extends AuthState {}

class CreateUserSuccess extends AuthState {}

class CreateUserFailure extends AuthState {
  final String errMessage;

  CreateUserFailure({required this.errMessage});
}

final class SignInLoading extends AuthState {}

final class SignInSuccess extends AuthState {}

final class SignInFailure extends AuthState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

class VerifyEmailFailure extends AuthState {
  final String errMessage;

  VerifyEmailFailure({required this.errMessage});
}

final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordFailure extends AuthState {
  final String errMessage;

  ResetPasswordFailure({required this.errMessage});
}

class ProfileImageSelected extends AuthState {
  final Uint8List? profileImage;

  ProfileImageSelected(this.profileImage);
}
class ProfileImageSelectionFailed extends AuthState {
  final String errMessage;
  ProfileImageSelectionFailed({required this.errMessage});
}

final class ObscuredPasswordTextState extends AuthState {}