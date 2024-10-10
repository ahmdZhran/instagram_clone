part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileThemeChanged extends ProfileState {
  final ThemeData themeData;

  ProfileThemeChanged({required this.themeData});

}
