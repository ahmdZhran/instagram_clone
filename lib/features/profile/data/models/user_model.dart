import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_profile_entity.dart';

class UserModel {
  final String uid;
  final String username;
  final String bio;
  final String profileImageUrl;
  final String name;
  final List<String> followers;
  final List<String> following;

  UserModel({
    required this.name,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      name: doc['name'],
      uid: doc['uid'],
      username: doc['user_name'],
      bio: doc['bio'],
      profileImageUrl: doc['profile_image'],
      followers: List<String>.from(doc['followers'] ?? []),
      following: List<String>.from(doc['following'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user_name': username,
      'bio': bio,
      'profile_image': profileImageUrl,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      uid: json['uid'],
      username: json['user_name'],
      bio: json['bio'],
      profileImageUrl: json['profile_image'],
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
    );
  }

  // UserProfileEntity toEntity() {
  //   return UserProfileEntity(
  //     uid: uid,
  //     username: username,
  //     bio: bio,
  //     profileImageUrl: profileImageUrl,
  //     name: name,
  //     followers: followers,
  //     following: following,
  //   );
  // }

  // factory UserModel.fromEntity(UserProfileEntity entity) {
  //   return UserModel(
  //     name: entity.name,
  //     uid: entity.uid,
  //     username: entity.username,
  //     bio: entity.bio,
  //     profileImageUrl: entity.profileImageUrl,
  //     followers: entity.followers,
  //     following: entity.following,
  //   );
  // }
}

