import '../data_source/local/user_local_data_source.dart';
import '../data_source/remote/user_remote_data_source.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/user_model.dart';

class ProfileRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final InternetConnectionChecker connectionChecker;

  ProfileRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  Future<UserProfileEntity> getProfileData(String userId) async {
    bool isConnected = await connectionChecker.hasConnection;
    if (isConnected) {
      final UserModel remoteData =
          await remoteDataSource.getUserProfile(userId);
      localDataSource.cacheUserProfile(remoteData);
      return remoteData.toEntity();
    } else {
      final UserModel? localData = localDataSource.getCachedUserProfile();
      if (localData != null) {
        return localData.toEntity();
      } else {
        throw Exception("no internet");
      }
    }
  }
}
