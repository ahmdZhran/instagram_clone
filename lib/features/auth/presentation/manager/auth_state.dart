part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ObscuredPasswordTextState extends AuthState {}
