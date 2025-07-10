import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import '../../features/profile/data/models/user_model.dart';

class UserProfileManager {
  static final UserProfileManager _instance = UserProfileManager._internal();

  UserProfileDataModel? userProfile;

  UserProfileManager._internal();

  factory UserProfileManager() {
    return _instance;
  }

  void updateUserProfileIfCurrentUser(
      UserProfileDataModel profile, String userId) {
    if (FirebaseAuth.instance.currentUser?.uid == userId) {
      userProfile = profile;
      log(userProfile!.name);
    }
  }

  void clearProfile() {
    userProfile = null;
  }

  UserProfileDataModel? getUserProfile() {
    return userProfile;
  }
}
