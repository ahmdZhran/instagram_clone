part of 'profile_cubit.dart';

class ProfileState {
  final ThemeData themeData;
  final Locale locale;

  const ProfileState({
    required this.themeData,
    required this.locale,
  });
  
  ProfileState copyWith({
    ThemeData? themeData,
    Locale? locale,
  }) {
    return ProfileState(
      themeData: themeData ?? this.themeData,
      locale: locale ?? this.locale,
    );
  }
}