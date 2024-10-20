import '../data_source/local/user_local_data_source.dart';
import '../data_source/remote/user_remote_data_source.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/user_model.dart';

class ProfileRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final InternetConnectionChecker _connectionChecker;

  ProfileRepository(
    this._remoteDataSource,
    this._localDataSource,
    this._connectionChecker,
  );

  Future<UserProfileEntity> getProfileData(String userId) async {
    bool isConnected = await _connectionChecker.hasConnection;
    if (isConnected) {
      final UserModel  remoteData = await _remoteDataSource.getUserProfile(userId);
      _localDataSource.cacheUserProfile(remoteData);
      return remoteData.toEntity();
    } else {
      final UserModel? localData = _localDataSource.getCachedUserProfile();
      if (localData != null) {
        return localData.toEntity();
      } else {
        throw Exception("no internet");
      }
    }
  }
}
