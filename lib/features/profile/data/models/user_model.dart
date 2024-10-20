import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserModel {
  final String username;
  final String name;
  final String bio;
  final String profileImageUrl;

  UserModel({
    required this.username,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      username: doc['username'],
      name: doc['name'],
      bio: doc['bio'],
      profileImageUrl: doc['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      name: json['name'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      username: username,
      name: name,
      bio: bio,
      profileImageUrl: profileImageUrl,
    );
  }

  factory UserModel.fromEntity(UserProfileEntity entity) {
    return UserModel(
      username: entity.username,
      name: entity.name,
      bio: entity.bio,
      profileImageUrl: entity.profileImageUrl,
    );
  }
}
