import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/helper/shared_pref_helper.dart';
import 'package:instagram_clone/features/profile/data/data_source/remote/user_remote_data_source.dart';
import 'package:instagram_clone/features/profile/data/repositories/profile_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'data/data_source/local/user_local_data_source.dart';

final profileDI = GetIt.instance;

class ProfileDI {
  Future<void> init() async {
    profileDI.registerLazySingleton<SharedPrefHelper>(() => SharedPrefHelper());
    profileDI.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSource(profileDI()));
    profileDI.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
    profileDI.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSource(profileDI()));
    profileDI.registerLazySingleton<ProfileRepository>(() => ProfileRepository(
          remoteDataSource: profileDI(),
          connectionChecker: profileDI(),
          localDataSource: profileDI(),
        ));
  }
}
