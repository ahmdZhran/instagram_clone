import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/features/profile/data/repositories/profile_repository.dart';

final profileDI = GetIt.instance;

class ProfileDI {
  Future<void> init() async {
    profileDI.registerLazySingleton<SharedPrefHelper>(() => SharedPrefHelper());
    profileDI.registerLazySingleton<ProfileRepository>(() => ProfileRepository(
          remoteDataSource: profileDI(),
          connectionChecker: profileDI(),
          localDataSource: profileDI(),
        ));
  }
}
