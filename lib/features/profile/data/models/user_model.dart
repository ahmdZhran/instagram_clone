import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserModel {
  final String uid;
  final String username;
  final String bio;
  final String profileImageUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      username: doc['user_name'],
      bio: doc['bio'],
      profileImageUrl: doc['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'user_name': username,
      'bio': bio,
      'profile_image': profileImageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['user_name'],
      bio: json['bio'],
      profileImageUrl: json['profile_image'],
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      uid: uid,
      username: username,
      bio: bio,
      profileImageUrl: profileImageUrl,
    );
  }

  factory UserModel.fromEntity(UserProfileEntity entity) {
    return UserModel(
      uid:entity.uid,
      username: entity.username,
      bio: entity.bio,
      profileImageUrl: entity.profileImageUrl,
    );
  }
}
