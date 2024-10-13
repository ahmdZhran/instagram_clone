part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileThemeChanged extends ProfileState {
  final bool isDark;

  ProfileThemeChanged({required this.isDark});
}
