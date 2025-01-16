import 'package:instagram_clone/features/profile/data/models/user_model.dart';


class UserProfileManager {
  static final UserProfileManager _instance = UserProfileManager._internal();

  UserModel? userProfile;

  UserProfileManager._internal();

  factory UserProfileManager() {
    return _instance;
  }

  void updateUserProfile(UserModel profile) {
    userProfile = profile;
    
  }

  void clearProfile() {
    userProfile = null;
  }
}
