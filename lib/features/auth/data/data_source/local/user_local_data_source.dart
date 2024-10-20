import 'package:instagram_clone/core/helper/shared_pref_helper.dart';

import '../../models/user_model.dart';

class UserLocalDataSource {
  final SharedPrefHelper _sharedPrefHelper;

  UserLocalDataSource(this._sharedPrefHelper);

  Future<void> cachUserProfile(UserModel user){
    
  }
}
