import 'package:flutter/widgets.dart';

import '../data_source/local/user_local_data_source.dart';
import '../data_source/remote/user_remote_data_source.dart';
import '../../domain/entities/user_profile_entity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/user_model.dart';
import '../models/user_post_model.dart';

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
    try {
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
          throw Exception("No internet connection");
        }
      }
    } catch (error) {
      debugPrint(
          "Error fetching profile data from repository: $error"); 
      rethrow;
    }
  }

  Future<UserProfileEntity> updateProfileData(
      UserProfileEntity profileEntity) async {
    try {
      bool isConnected = await connectionChecker.hasConnection;
      if (isConnected) {
        final userModel = UserModel(
          name: profileEntity.name,
          username: profileEntity.username,
          bio: profileEntity.bio,
          profileImageUrl: profileEntity.profileImageUrl,
          uid: profileEntity.uid,
          followers: profileEntity.followers,
          following: profileEntity.following,
        );
        final updatedUser = await remoteDataSource.updateUserProfile(
          profileEntity.uid,
          userModel,
        );
        return updatedUser.toEntity();
      } else {
        throw Exception("No internet connection");
      }
    } catch (error) {
      debugPrint(
          "Error updating profile data in repository: $error");
      rethrow;
    }
  }

  Future<List<UserPostModel>> getUserPosts(String userId) async {
    try {
      return await remoteDataSource.getUserPosts(userId);
    } catch (error) {
      debugPrint(
          "Error fetching user posts in repository: $error");
      rethrow;
    }
  }

  Future<void> followUser(String currentUserId, String targetUserId) async {
    try {
      await remoteDataSource.followUser(currentUserId, targetUserId);
    } catch (error) {
      debugPrint(
          "Error following user in repository: $error");
      rethrow;
    }
  }

  Future<void> unFollowUser(String currentUserId, String targetUserId) async {
    try {
      await remoteDataSource.unFollowUser(currentUserId, targetUserId);
    } catch (error) {
      debugPrint(
          "Error unfollowing user in repository: $error"); 
      rethrow;
    }
  }
}
