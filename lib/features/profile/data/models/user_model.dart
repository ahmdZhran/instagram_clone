import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileDataModel {
  final String uid;
  final String username;
  final String bio;
  final String profileImageUrl;
  final String name;
  final List<String> followers;
  final List<String> following;

  UserProfileDataModel({
    required this.name,
    required this.uid,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });

  factory UserProfileDataModel.fromDocument(DocumentSnapshot doc) {
    return UserProfileDataModel(
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

  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDataModel(
      name: json['name'],
      uid: json['uid'],
      username: json['user_name'],
      bio: json['bio'],
      profileImageUrl: json['profile_image'],
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
    );
  }

  UserProfileDataModel copyWith({
    String? name,
    String? uid,
    String? username,
    String? bio,
    String? profileImageUrl,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserProfileDataModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
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
