import 'package:flutter/widgets.dart';

import '../data_source/local/user_local_data_source.dart';
import '../data_source/remote/user_remote_data_source.dart';
import '../../domain/entities/user_profile_entity.dart';

import '../models/user_model.dart';
import '../models/user_post_model.dart';

class ProfileRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  ProfileRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<UserProfileEntity> getProfileData(String userId) async {
    try {
      final UserModel remoteData = await remoteDataSource.getUserProfile(userId);
      localDataSource.cacheUserProfile(remoteData);
      return remoteData.toEntity();
    } catch (error) {
      debugPrint(
          "Error fetching profile data from repository: $error");
      rethrow;
    }
  }

  Future<UserProfileEntity> updateProfileData(
      UserProfileEntity profileEntity) async {
    try {
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
