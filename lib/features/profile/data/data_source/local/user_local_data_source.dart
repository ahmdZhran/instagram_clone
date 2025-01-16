import '../../../../../core/helper/shared_pref_helper.dart';
import '../../../../../core/helper/shared_pref_keys.dart';
import 'dart:convert';

import '../../models/user_model.dart';

class UserLocalDataSource {
  final SharedPrefHelper _sharedPrefHelper;

  UserLocalDataSource(this._sharedPrefHelper);

  Future<void> cacheUserProfile(UserProfileDataModel user) async {
    final jsonString = json.encode(user.toJson());
    await _sharedPrefHelper.saveData(
        key: SharedPrefKeys.cachedUserProfile, value: jsonString);
  }

  UserProfileDataModel? getCachedUserProfile() {
    final jsonString =
        _sharedPrefHelper.getData(key: SharedPrefKeys.cachedUserProfile);

    if (jsonString != null) {
      return UserProfileDataModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
