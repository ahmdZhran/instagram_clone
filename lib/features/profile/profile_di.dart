import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';

final profileDI = GetIt.instance;

class ProfileDI {
  Future<void> init() async {
    profileDI.registerLazySingleton(() => SharedPrefHelper());
  }
}
