import '../../features/profile/domain/entities/user_profile_entity.dart';

class UserProfileManager {
  static final UserProfileManager _instance = UserProfileManager._internal();

  UserProfileEntity? userProfile;

  UserProfileManager._internal();

  factory UserProfileManager() {
    return _instance;
  }

  void updateUserProfile(UserProfileEntity profile) {
    userProfile = profile;
  }

  void clearProfile() {
    userProfile = null;
  }
}
