import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/services/firebase_storage_service.dart';
import '../../core/helper/shared_pref_helper.dart';
import 'data/data_source/remote/user_remote_data_source.dart';
import 'data/repositories/profile_repository.dart';

import 'data/data_source/local/user_local_data_source.dart';

final profileDI = GetIt.instance;

class ProfileDI {
  Future<void> init() async {
    profileDI.registerLazySingleton<SharedPrefHelper>(() => SharedPrefHelper());
    profileDI.registerLazySingleton<FirebaseStorageService>(
        () => FirebaseStorageService());
    profileDI.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSource(profileDI()));
    profileDI.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSource(profileDI()));
    profileDI.registerLazySingleton<ProfileRepository>(() => ProfileRepository(
          remoteDataSource: profileDI(),
          localDataSource: profileDI(),
        ));
  }
}
